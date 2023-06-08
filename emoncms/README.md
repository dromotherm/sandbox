# pushing to the hub

```
docker login --username=yourhubusername
docker tag source alexjunk/emoncms/tag
docker push
```

# reducing image size

https://ubuntu.com/blog/we-reduced-our-docker-images-by-60-with-no-install-recommends

https://unix.stackexchange.com/questions/457473/supervisord-does-not-exit-after-one-service-crashed-in-a-docker-container

# docker and systemd

https://medium.com/swlh/docker-and-systemd-381dfd7e4628

https://github.com/j8r/dockerfiles

https://serverfault.com/questions/1053187/systemd-fails-to-run-in-a-docker-container-when-using-cgroupv2-cgroupns-priva

https://stackoverflow.com/questions/39169403/not-able-to-use-systemd-on-ubuntu-docker-container

https://developers.redhat.com/blog/2014/05/05/running-systemd-within-docker-container

https://stackoverflow.com/questions/16047306/how-is-docker-different-from-a-virtual-machine?rq=1

https://askubuntu.com/questions/1270757/how-can-i-use-systemctl-from-within-a-docker-container-run-on-ubuntu-20-04-wit

https://github.com/robertdebock/docker-ubuntu-systemd/tree/master
