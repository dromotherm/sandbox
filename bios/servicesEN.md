# emoncms_mqtt service operation

As a reminder, when we post in the broker on the topic `emon/nodeid` or on `emon/userid/nodeid` in multi-user mode, we generally send a payload in json format:
`{temp:24.7, rh:56.8}`

This payload example contains 2 inputs : temp and rh

For the first input, we have :
```
$name = "temp";
$value = 24.7;
```

When a json payload is received from the broker, the service updates somes hashes in redis:

hash | value
--|--
`input:lastvalue:$inputid` | `{"time":$time, "value":$value}`

To achieve this, the service calls the method `set_timevalue($nodeid,$time,$value)` of the class Input class (cf input_model.php)
```
$dbinputs = $input->get_inputs($userid);
$inputid = $dbinputs[$nodeid][$name]['id'];
$input->set_timevalue($inputid,$time,$value);
```
Simultaneously, the service checks if there is one or more processes on each concerned input and applies them using the `input` method of the Process class (cf process_model.php)

Emoncms offers many processes and uses the log_to_feed process for data historization

the `log_to_feed` method of the Process_ProcessList class (cf process_processlist.php) calls the `insert_data` method of the Feed class (cf feed_model.php)
```
$this->feed->insert_data($id, $time, $time, $value);
```
The `insert_data($feedid,$updatetime,$feedtime,$value,$arg=null)` method writes directly into the timeseries with the corresponding engine or creates the buffer in redis :
```
$engine = $this->get_engine($feedid);
$args = array('engine'=>$engine,'updatetime'=>$updatetime,'arg'=>$arg);
$this->EngineClass(Engine::REDISBUFFER)->post($feedid,$feedtime,$value,$args); 
```
The code for the `post` method of the RedisBuffer class is as follows:
```
public function post($feedid,$time,$value,$args=null)
    {
        $arg = $args['arg'];
        $engine = $args['engine'];
        $updatetime = $args['updatetime']; // This is time it was received not time for value
        if ($arg != null) $arg="|".json_encode($arg);

        $this->redis->zAdd("feed:$feedid:buffer",(int)$time,dechex((int)$updatetime)."|".$value.$arg);
        $this->redis->sAdd("feed:bufferactive",$feedid);
    }
```
Now it's up to the feedwriter service to take the lead.

# feedwriter service operation
```
while(true)
    {
        $feed->EngineClass(Engine::REDISBUFFER)->process_buffers();
        sleep((int)$settings['feed']['redisbuffer']['sleep']);
    }
```
for all feed numbers specified in the redis set `feed:bufferactive`, the data engine number is retrieved:
```
$feeddata = $this->redis->hGetAll("feed:$feedid");
$engine = $feeddata['engine'];
```
The elements of the zset `feed:$feedid:buffer` are read and processed one after the other :
```
if ($arg == "U" || $lasttime == $time) {
    $this->feed->EngineClass($engine)->update($feedid,$time,$value);
} else {
    $this->feed->EngineClass($engine)->post_bulk_prepare($feedid,$time,$value,$arg);
}
$lasttime=$time;
```
post_bulk_prepare provides 2 variables to the data engine : `$writebuffer` and `$lastvalue_cache`.
```
$pos = floor(($time - $meta->start_time) / $meta->interval);
$last_pos = $meta->npoints - 1;
$npadding = ($pos - $last_pos)-1;
for ($n=0; $n<$npadding; $n++)
    {
    $this->writebuffer[$feedid] .= pack("f",$padding_value);
    }
$this->writebuffer[$feedid] .= pack("f",$value);
$this->lastvalue_cache[$feedid] = $value;
```
`$padding_value` is either a NAN if data gaps are accepted, or a linearly interpolated value

Writing to feeds is finally achieved by `post_bulk_save()` by browsing `$writebuffer`:
```
$this->feed->EngineClass($engine)->post_bulk_save();
```

