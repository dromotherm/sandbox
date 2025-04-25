To install : https://github.com/netbox-community/netbox-docker


https://netboxlabs.com/docs/netbox/en/stable/administration/replicating-netbox/

```
pg_dump --username netbox --password --host localhost --exclude-table-data=extras_objectchange netbox > netbox.sql
```

copy the dump to the host :

```
sudo docker cp netbox-docker-postgres-1:netbox.sql .
```
