Pour lister les processus : `ps -aux`

```
root     23526  0.0  0.0      0     0 ?        I<   17:45   0:00 [kworker/0:2H]
root     23701  0.0  0.0      0     0 ?        I    17:46   0:00 [kworker/1:2-cgroup_destroy]
root     23820  0.0  0.0      0     0 ?        I<   17:46   0:00 [kworker/1:2H]
bios     23834  5.5 17.7 368372 176864 ?       Ssl  17:47   0:27 python3 /usr/local/bin/bios/bios.py --config-file=/etc/bios/bios.conf --log-file=/var
root     23861  0.0  0.0      0     0 ?        I    17:47   0:00 [kworker/0:0-cgroup_destroy]
root     23951  0.0  0.0      0     0 ?        I    17:48   0:00 [kworker/3:3-events]
root     24224  0.0  0.0      0     0 ?        I    17:50   0:00 [kworker/2:1-events]
root     24347  0.0  0.0      0     0 ?        I    17:51   0:00 [kworker/1:0-cgroup_destroy]
root     24462  0.0  0.0      0     0 ?        I    17:52   0:00 [kworker/0:1-cgroup_destroy]
root     24567  0.0  0.0      0     0 ?        I<   17:53   0:00 [kworker/2:2H]
root     24678  0.0  0.0      0     0 ?        I    17:53   0:00 [kworker/3:0-events]
root     24816  1.7  0.6  12204  6316 ?        Ss   17:54   0:00 sshd: pi [priv]
pi       24830  1.8  0.6  14572  6808 ?        Ss   17:54   0:00 /lib/systemd/systemd --user
pi       24833  0.0  0.3  35352  3480 ?        S    17:54   0:00 (sd-pam)
pi       24849  0.3  0.3  12204  3660 ?        R    17:54   0:00 sshd: pi@pts/0
pi       24852  3.3  0.3   8488  3640 pts/0    Ss   17:54   0:00 -bash
pi       24890  0.0  0.2   9788  2504 pts/0    R+   17:55   0:00 ps -aux
www-data 25429  0.0  2.5 223272 25532 ?        S    May13   0:06 /usr/sbin/apache2 -k start
```

Pour auditer le pourcentage de CPU utilisé par les processus, on utilise la commande `top`
```
top - 17:48:40 up 5 days, 22:13,  1 user,  load average: 0.35, 0.89, 1.23
Tasks: 122 total,   1 running, 121 sleeping,   0 stopped,   0 zombie
%Cpu(s):  5.7 us,  2.0 sy,  0.0 ni, 92.2 id,  0.0 wa,  0.0 hi,  0.1 si,  0.0 st
MiB Mem :    975.6 total,    100.8 free,    296.3 used,    578.5 buff/cache
MiB Swap:    100.0 total,    100.0 free,      0.0 used.    540.3 avail Mem 

  PID USER      PR  NI    VIRT    RES    SHR S  %CPU  %MEM     TIME+ COMMAND    
  415 emonhub   20   0   72832  19892   6568 S  12.8   2.0 578:08.71 python     
  680 root      20   0   80520  21980  17316 S   6.9   2.2 427:15.66 php        
  586 redis     20   0   45896   4748   2984 S   4.9   0.5 328:56.07 redis-ser+ 
23834 bios      20   0  368372 176864  99880 S   3.3  17.7   0:13.10 python3    
21980 www-data  20   0  220592  24072  16324 S   1.6   2.4   0:01.44 apache2    
  518 mosquit+  20   0    8904   5084   4528 S   1.0   0.5  47:36.57 mosquitto  
23900 pi        20   0   10188   2840   2480 R   0.7   0.3   0:00.52 top        
   10 root      20   0       0      0      0 I   0.3   0.0  12:52.37 rcu_sched  
  614 mysql     20   0  725604  61972  15700 S   0.3   6.2  10:18.19 mysqld     
  845 pi        20   0   80520  21316  17056 S   0.3   2.1  35:30.80 php        
    1 root      20   0   33812   8152   6448 S   0.0   0.8   3:16.44 systemd    
    2 root      20   0       0      0      0 S   0.0   0.0   0:00.79 kthreadd   
    3 root       0 -20       0      0      0 I   0.0   0.0   0:00.00 rcu_gp     
    4 root       0 -20       0      0      0 I   0.0   0.0   0:00.00 rcu_par_gp 
    8 root       0 -20       0      0      0 I   0.0   0.0   0:00.00 mm_percpu+ 
    9 root      20   0       0      0      0 S   0.0   0.0   1:20.48 ksoftirqd+ 
   11 root      20   0       0      0      0 I   0.0   0.0   0:00.00 rcu_bh
```
Par défaut, top affiche les choses en environnement single core et sur un quadcore comme le RPI3, un pourcentage de CPU de 100% indique qu'un coeur est utilisé à 100%

Pour basculer dans l'affichage multicore, `shift+I`
