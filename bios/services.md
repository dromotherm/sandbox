# fonctionnement du service emoncms_mqtt

Pour rappel, quant on poste dans le broker sur le topic `emon/nodeid` ou sur `emon/userid/nodeid` quant on est en multiutilisateur, on envoie généralement un payload au format json :
`{temp:24.7, rh:56.8}`

Cet exemple de payload contient 2 inputs : temp et rh 

Pour le premier input, on a :
```
$name = "temp";
$value = 24.7;
```

quant un payload json est reçu depuis le broker, le service met à jour des hash dans redis:

hash | valeur
--|--
`input:lastvalue:$inputid` | `{"time":$time, "value":$value}`

Pour celà, le service appelle la méthode `set_timevalue($nodeid,$time,$value)` de la class Input (cf input_model.php)
```
$dbinputs = $input->get_inputs($userid);
$inputid = $dbinputs[$nodeid][$name]['id'];
$input->set_timevalue($inputid,$time,$value);
```

En parallèle, le service vérifie s'il y a un ou des process sur chaque input concerné et les applique, en appelant la méthode `input` de la class Process (cf process_model.php)

Emoncms offre beaucoup de process mais on utilise principalement log_to_feed

la méthode `log_to_feed` de la classe Process_ProcessList (cf process_processlist.php) appelle la méthode `insert_data` de classe Feed (cf feed_model.php)
```
$this->feed->insert_data($id, $time, $time, $value);
```
Cette méthode `insert_data($feedid,$updatetime,$feedtime,$value,$arg=null)` écrit directement dans la timeserie avec le moteur correspondant ou crée le buffer dans redis :
```
$engine = $this->get_engine($feedid);
$args = array('engine'=>$engine,'updatetime'=>$updatetime,'arg'=>$arg);
$this->EngineClass(Engine::REDISBUFFER)->post($feedid,$feedtime,$value,$args); 
```
Le code de la méthode `post` de la classe RedisBuffer est le suivant :
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
Désormais c'est au service feedwriter de prendre la main.

# fonctionnement du feedwriter
```
while(true)
    {
        $feed->EngineClass(Engine::REDISBUFFER)->process_buffers();
        sleep((int)$settings['feed']['redisbuffer']['sleep']);
    }
```
pour tous numéros de flux indiqués dans le set redis `feed:bufferactive`, on récupère le numéro du moteur de données :
```
$feeddata = $this->redis->hGetAll("feed:$feedid");
$engine = $feeddata['engine'];
```
on lit ensuite les éléments contenus dans le zset `feed:$feedid:buffer` et on les traite les uns après les autres de la manière suivante :

```
if ($arg == "U" || $lasttime == $time) {
    $this->feed->EngineClass($engine)->update($feedid,$time,$value);
} else {
    $this->feed->EngineClass($engine)->post_bulk_prepare($feedid,$time,$value,$arg);
}
$lasttime=$time;
```
post_bulk_prepare nourrit 2 variables du moteur de données : `$writebuffer` et `$lastvalue_cache`
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
`$padding_value` est soit un NAN si on accepte les trous de données, soit une valeur interpolée linéairement

Enfin, l'écriture dans les flux est réalisé par `post_bulk_save()` en parcourant `$writebuffer`:
```
$this->feed->EngineClass($engine)->post_bulk_save();
```

