# tracking init_resize modifications

raspbian init resize file

https://github.com/RPi-Distro/raspi-config/blob/master/usr/lib/raspi-config/init_resize.sh

our file needed to be reconfigured to integrate their changes

tracability of our only changes is here :

https://github.com/openenergymonitor/EmonScripts/commit/8f5baa011b3a52e8f992a0f075756b363c488f84

# how to manage sectors

1 kibioctet (kio) 	= 2^10 octets 	= 1 024 o 	= 1 024 octets

1 mébioctet (Mio) 	= 2^20 octets 	= 1 024 kio 	= 1 048 576 octets

1 gibioctet (Gio) 	= 2^30 octets 	= 1 024 Mio 	= 1 073 741 824 octets

1 tébioctet (Tio) 	= 2^40 octets 	= 1 024 Gio 	= 1 099 511 627 776 octets

1 pébioctet (Pio) 	= 2^50 octets 	= 1 024 Tio 	= 1 125 899 906 842 624 octets

1 exbioctet (Eio) 	= 2^60 octets 	= 1 024 Pio 	= 1 152 921 504 606 846 976 octets

1 zébioctet (Zio) 	= 2^70 octets 	= 1 024 Eio 	= 1 180 591 620 717 411 303 424 octets

1 yobioctet (Yio) 	= 2^80 octets 	= 1 024 Zio 	= 1 208 925 819 614 629 174 706 176 octets 

https://fr.wikipedia.org/wiki/Octet

Avec des secteurs de 512 octets :

10 Gio = 10 * 1073741824 / 512 = 20971520 secteurs

20 Gio = 41943040 secteurs
