
# GPU

https://askubuntu.com/questions/5417/how-to-get-the-gpu-info

la commande `lspci` déatille le matériel présent sur le PC notamment la carte graphique

```
GPU=$(lspci | grep VGA | cut -d ":" -f3);RAM=$(cardid=$(lspci | grep VGA |cut -d " " -f1);lspci -v -s $cardid | grep " prefetchable"| cut -d "=" -f2);echo $GPU $RAM
```

https://www.tensorflow.org/install/gpu?hl=fr
