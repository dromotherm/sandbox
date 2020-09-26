# Empower EmonCMS with Redis storage of forecasting datas coming from various API

There is really no point in storing weather forecasts on disk. But it can be nice to compare them to the field truth in order to choose the most suitable forecasting API. The ultimate goal is to run physical/statistical models on these forecasts to predict the evolution of the indoor temperature in a building. 

Of course, you can do this in python, using numpy arrays which are much used in the datascience world. Numpy arrays are easily storable in Redis in a binary form. But you have to collect the datas. As far as data collection is concerned, EmonCMS is really a must have. EmonCMS is strongly interfaced to a Redis database, used as a collecting buffer to reduce disk writing operations and also to store feeds metadatas.

My feeling is that it should be easy to send data batches as numpy array in Redis and to display them in EmonCMS, using the graph module and others visualization tools...

All we have to do is to write some minimalistic pieces of code in PHP and python :-) and also to have a good understanding of the EmonCMS architecture. For all back-office aspects, EmonCMS is well structured, but the documentation is not always available, because of the lack of technical writers on the project. Front-office is really a bunck of noodles and sometimes you don't known were to find things but happily Trystan Lea and Emrys Roberts are doing very efficient jobs...

emonCMS feeds are stored in Redis under the `feed` key

To create a new temporary feed (no existence on disk neither in the mariadb database) :
1) choose a quite big `int`, which will be the feed id : the starting timestamp of your feed can be a good choice, because it is very unlikely that you already created more streams than the timestamp number :-)
2) create a hash with the essential metadatas : datatype, engine, name, id, userid and public which can be blank. We can also add a tag for classification in emonCMS.

Redis can manage various keys : string, hash, zset, list and set. depending on the key type, you have to use a specific method to retrieve the values :
```
keys = redis.keys('*')
for key in keys:
    type = redis.type(key)
    if type == "string":
        val = redis.get(key)
    if type == "hash":
        vals = redis.hgetall(key)
    if type == "zset":
        vals = redis.zrange(key, 0, -1)
    if type == "list":
        vals = redis.lrange(key, 0, -1)
    if type == "set":
        vals = redis. smembers(key)
```
In order to create an emoncms feed using python, we will have to deal with hash, set and string keys :


We will have to modify 3 files :
- Modules/feed/feed_controller.php
- Modules/feed/engine/RedisBuffer.php
- Modules/feed/feed_model.php

## datatype numbers defined in `lib/enum.php`

number|datatype
--|--
0|undefined
1|realtime
2|daily
3|histogram

## engine numbers defined in `lib/enum.php`

number|engine
--|--
0|MYSQL
1|TIMESTORE = Depreciated
2|PHPTIMESERIES
3|GRAPHITE = Not included in core
4|PHPTIMESTORE = Depreciated
5|PHPFINA
6|PHPFIWA
7|VIRTUALFEED = Virtual feed, on demand post processing
8|MYSQLMEMORY = Mysql with MEMORY tables on RAM. All data is lost on shutdown
9|REDISBUFFER = (internal use only) Redis Read/Write buffer, for low write mode
10|CASSANDRA = Cassandra
