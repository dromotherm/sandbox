check the largest files in /var/log

```
sudo du -a /var/log/* | sort -n -r | head -n 30
```
