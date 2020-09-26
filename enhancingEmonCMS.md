# Empower EmonCMS with Redis storage of forecasting datas coming from various API

There is really no point in storing weather forecasts on disk. But it can be nice to compare them to the field truth in order to choose the most suitable forecasting API. The ultimate goal is to run physical/statistical models on these forecasts to predict the evolution of the indoor temperature in a building. 

Of course, you can do this in python, using numpy arrays which are much used in the datascience world. Numpy arrays are easily storable in Redis in a binary form. But you have to collect the datas. As far as data collection is concerned, EmonCMS is really a must have. EmonCMS is strongly interfaced to a Redis database, used as a collecting buffer to reduce disk writing operations and also to store feeds metadatas.

My feeling is that it should be easy to send data batches as numpy array in Redis and to display them in EmonCMS, using the graph module and others visualization tools...

All we have to do is to write some minimalistic pieces of code in PHP and python :-) and also to have a good understanding of the EmonCMS architecture. For all back-office aspects, EmonCMS is well structured, but the documentation is not always available, because of the lack of technical writers on the project. Front-office is really a bunch of noodles and sometimes you don't known were to find things but happily Trystan Lea and Emrys Roberts are doing very efficient jobs...

emonCMS feeds are stored in Redis under the `feed` key

To create a new temporary feed (no existence on disk neither in the mariadb database) :
1) choose a quite big `int`, which will be the feed id : the starting timestamp of your feed can be a good choice, because it is very unlikely that you already created more streams than the timestamp number :-)
2) create a redis hash with the essential metadatas : datatype, engine, name, id, userid and public which can be blank. We can also add a tag for classification in emonCMS.
3) add the feed id to the user feed list which is stored in redis as a set
4) inject the data as binary in a string buffer

The numpy array should be constructed with axis 0 as time :
- column 0 is timestamp expressed in seconds
- column 1 to 3 are datas : in our case, column 1 is nebulosity in %, column 2 is predicted outdoor temperature and column 3 temperature as felt by a human perception
```
import numpy as np
data = np.array(
[[ 1.6011252e+09,  7.5000000e+01,  1.2000000e+01,  6.3500000e+00],
 [ 1.6011288e+09,  5.3000000e+01,  1.1700000e+01,  6.3900000e+00],
 [ 1.6011324e+09,  3.2000000e+01,  1.1660000e+01,  6.7200000e+00],
 [ 1.6011360e+09,  2.0000000e+01,  1.1250000e+01,  7.1200000e+00],
 [ 1.6011396e+09,  1.3000000e+01,  9.4700000e+00,  6.3200000e+00],
 [ 1.6011432e+09,  1.1000000e+01,  6.5800000e+00,  3.4400000e+00],
 [ 1.6011468e+09,  0.0000000e+00,  5.5100000e+00,  2.4800000e+00],
 [ 1.6011504e+09,  0.0000000e+00,  5.2000000e+00,  1.9900000e+00],
 [ 1.6011540e+09,  1.0000000e+00,  5.0000000e+00,  1.6500000e+00],
 [ 1.6011576e+09,  7.0000000e+00,  4.5300000e+00,  1.2200000e+00],
 [ 1.6011612e+09,  7.0000000e+00,  3.8000000e+00,  3.3000000e-01],
 [ 1.6011648e+09,  9.0000000e+00,  3.2800000e+00, -1.7000000e-01],
 [ 1.6011684e+09,  2.4000000e+01,  2.9500000e+00, -4.7000000e-01],
 [ 1.6011720e+09,  6.2000000e+01,  3.8100000e+00,  2.2000000e-01],
 [ 1.6011756e+09,  7.5000000e+01,  5.4600000e+00,  2.1400000e+00],
 [ 1.6011792e+09,  8.1000000e+01,  6.0500000e+00,  2.4800000e+00],
 [ 1.6011828e+09,  8.5000000e+01,  6.4900000e+00,  2.3900000e+00],
 [ 1.6011864e+09,  8.7000000e+01,  6.8300000e+00,  2.4200000e+00],
 [ 1.6011900e+09,  1.0000000e+02,  6.9000000e+00,  2.0100000e+00],
 [ 1.6011936e+09,  1.0000000e+02,  7.1100000e+00,  1.9300000e+00],
 [ 1.6011972e+09,  1.0000000e+02,  6.6900000e+00,  1.2800000e+00],
 [ 1.6012008e+09,  1.0000000e+02,  6.2700000e+00,  9.2000000e-01],
 [ 1.6012044e+09,  1.0000000e+02,  6.8100000e+00,  1.2600000e+00],
 [ 1.6012080e+09,  1.0000000e+02,  6.7900000e+00,  1.1100000e+00],
 [ 1.6012116e+09,  1.0000000e+02,  6.9900000e+00,  1.2700000e+00],
 [ 1.6012152e+09,  1.0000000e+02,  7.0200000e+00,  2.0200000e+00],
 [ 1.6012188e+09,  1.0000000e+02,  7.5900000e+00,  1.9900000e+00],
 [ 1.6012224e+09,  1.0000000e+02,  8.3300000e+00,  2.9300000e+00],
 [ 1.6012260e+09,  1.0000000e+02,  8.7600000e+00,  3.6100000e+00],
 [ 1.6012296e+09,  1.0000000e+02,  9.1600000e+00,  3.9900000e+00],
 [ 1.6012332e+09,  1.0000000e+02,  9.6900000e+00,  5.1800000e+00],
 [ 1.6012368e+09,  1.0000000e+02,  1.0160000e+01,  6.1200000e+00],
 [ 1.6012404e+09,  1.0000000e+02,  1.0420000e+01,  7.3700000e+00],
 [ 1.6012440e+09,  1.0000000e+02,  1.0580000e+01,  7.7700000e+00],
 [ 1.6012476e+09,  1.0000000e+02,  1.0660000e+01,  7.5500000e+00],
 [ 1.6012512e+09,  1.0000000e+02,  1.0000000e+01,  6.4600000e+00],
 [ 1.6012548e+09,  4.9000000e+01,  9.5600000e+00,  6.4100000e+00],
 [ 1.6012584e+09,  7.3000000e+01,  9.8900000e+00,  7.0700000e+00],
 [ 1.6012620e+09,  8.1000000e+01,  9.8500000e+00,  7.2700000e+00],
 [ 1.6012656e+09,  8.3000000e+01,  9.3300000e+00,  6.9800000e+00],
 [ 1.6012692e+09,  8.4000000e+01,  8.9300000e+00,  6.9500000e+00],
 [ 1.6012728e+09,  8.6000000e+01,  8.9000000e+00,  7.1500000e+00],
 [ 1.6012764e+09,  9.8000000e+01,  9.0200000e+00,  7.4000000e+00],
 [ 1.6012800e+09,  9.8000000e+01,  9.7300000e+00,  8.0700000e+00],
 [ 1.6012836e+09,  9.6000000e+01,  1.1150000e+01,  9.3700000e+00],
 [ 1.6012872e+09,  8.9000000e+01,  1.2740000e+01,  1.0520000e+01],
 [ 1.6012908e+09,  8.6000000e+01,  1.3250000e+01,  1.0720000e+01],
 [ 1.6012944e+09,  8.8000000e+01,  1.3040000e+01,  1.1010000e+01]])
```





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

## redis keys
Redis can manage various keys : string, hash, zset, list and set. Depending on the key type, you have to use a specific method to retrieve the values : get for string, hgetall for hash, zrange for zset, lrange for list and smembers for set.
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
        vals = redis.smembers(key)
```
