## datatype numbers defined in `lib/enum.php`

number|datatype
--|--
0|undefinded
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
