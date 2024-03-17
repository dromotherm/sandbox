# TESTING THE RADIO RECEIVER WITH THE 64 BITS RASPI OS ON THE RASPBERRY


started manually by running on the bios2 network create with docker compose

```
sudo docker run --rm --network=bios2_default --device-cgroup-rule='c 204:* rmw' --device-cgroup-rule='c 188:* rmw' -v $(pwd):/bios -v /dev:/dev -e MQTT_HOST="themis" -it alexjunk/tf:ubuntu22.04_tflite2.13.0_paho1.6.1_pymodbus3.4.1 bash
```
then running the ota2 sniffer : `python3 /bios/hardware/ota2.py --conf=/bios/conf/ota2.conf`

using on the host journactl to follow the logs :

```
journalctl -n 100
```


a lot of warnings like : `WARN::dwc_otg_hcd_urb_dequeue:638: Timed out waiting for FSM NP transfer to complete on 1`

and usb is disconnected :

```
Mar 17 15:56:48 raspberrypi kernel: usb 1-1: USB disconnect, device number 8
Mar 17 15:56:48 raspberrypi kernel: usb 1-1.1: USB disconnect, device number 9
Mar 17 15:56:48 raspberrypi kernel: smsc95xx 1-1.1:1.0 eth0: unregister 'smsc95xx' usb-3f980000.usb-1.1, smsc95xx USB 2.0 Ethernet
Mar 17 15:56:48 raspberrypi kernel: smsc95xx 1-1.1:1.0 eth0: Link is Down
Mar 17 15:56:48 raspberrypi kernel: smsc95xx 1-1.1:1.0 eth0: hardware isn't capable of remote wakeup
Mar 17 15:56:48 raspberrypi avahi-daemon[494]: Leaving mDNS multicast group on interface eth0.IPv6 with address fe80::7aba:daf8:354b:e037.
Mar 17 15:56:48 raspberrypi avahi-daemon[494]: Interface eth0.IPv4 no longer relevant for mDNS.
Mar 17 15:56:48 raspberrypi avahi-daemon[494]: Leaving mDNS multicast group on interface eth0.IPv4 with address 192.168.1.109.
Mar 17 15:56:48 raspberrypi avahi-daemon[494]: Withdrawing address record for fe80::7aba:daf8:354b:e037 on eth0.
Mar 17 15:56:48 raspberrypi avahi-daemon[494]: Withdrawing address record for 192.168.1.109 on eth0.
Mar 17 15:56:48 raspberrypi NetworkManager[561]: <info>  [1710687408.3013] device (eth0): state change: activated -> unmanaged (reason 'removed', sys-iface-state: 'removed')
Mar 17 15:56:48 raspberrypi kernel: usb 1-1.3: USB disconnect, device number 10
Mar 17 15:56:48 raspberrypi kernel: ftdi_sio ttyUSB0: error from flowcontrol urb
Mar 17 15:56:48 raspberrypi kernel: ftdi_sio ttyUSB0: FTDI USB Serial Device converter now disconnected from ttyUSB0
Mar 17 15:56:48 raspberrypi kernel: ftdi_sio 1-1.3:1.0: device disconnected
```
https://github.com/raspberrypi/firmware/issues/1804

with dwc2, things are not better : `dwc2 3f980000.usb: dwc2_hc_chhltd_intr_dma: Channel 4 - ChHltd set, but reason is unknown`

```
Mar 17 16:45:09 raspberrypi kernel: usb 1-1.5: new full-speed USB device number 8 using dwc2
Mar 17 16:45:09 raspberrypi kernel: usb 1-1.5: New USB device found, idVendor=0403, idProduct=6001, bcdDevice= 6.00
Mar 17 16:45:09 raspberrypi kernel: usb 1-1.5: New USB device strings: Mfr=1, Product=2, SerialNumber=3
Mar 17 16:45:09 raspberrypi kernel: usb 1-1.5: Product: FT232R USB UART
Mar 17 16:45:09 raspberrypi kernel: usb 1-1.5: Manufacturer: FTDI
Mar 17 16:45:09 raspberrypi kernel: usb 1-1.5: SerialNumber: AQ00G2PX
Mar 17 16:45:09 raspberrypi mtp-probe[1615]: checking bus 1, device 8: "/sys/devices/platform/soc/3f980000.usb/usb1/1-1/1-1.5"
Mar 17 16:45:09 raspberrypi mtp-probe[1615]: bus: 1, device: 8 was not an MTP device
Mar 17 16:45:09 raspberrypi kernel: usbcore: registered new interface driver usbserial_generic
Mar 17 16:45:09 raspberrypi kernel: usbserial: USB Serial support registered for generic
Mar 17 16:45:09 raspberrypi kernel: usbcore: registered new interface driver ftdi_sio
Mar 17 16:45:09 raspberrypi kernel: usbserial: USB Serial support registered for FTDI USB Serial Device
Mar 17 16:45:09 raspberrypi kernel: ftdi_sio 1-1.5:1.0: FTDI USB Serial Device converter detected
Mar 17 16:45:09 raspberrypi kernel: usb 1-1.5: Detected FT232R
Mar 17 16:45:09 raspberrypi kernel: usb 1-1.5: FTDI USB Serial Device converter now attached to ttyUSB0
Mar 17 16:45:09 raspberrypi mtp-probe[1619]: checking bus 1, device 8: "/sys/devices/platform/soc/3f980000.usb/usb1/1-1/1-1.5"
Mar 17 16:45:09 raspberrypi mtp-probe[1619]: bus: 1, device: 8 was not an MTP device
Mar 17 16:45:12 raspberrypi ModemManager[628]: <info>  [base-manager] couldn't check support for device '/sys/devices/platform/soc/3f980000.usb/usb1/1-1/1-1.5': not supported by any plugin
Mar 17 16:46:56 raspberrypi ihm2.py[1290]: 2024-03-17 16:46:56,097 INFO     going to sleep 1710690416
Mar 17 16:47:18 raspberrypi dockerd[734]: 2024/03/17 16:47:18 http: superfluous response.WriteHeader call from go.opentelemetry.io/contrib/instrumentation/net/http/otelhttp.(*respWriterWrapper).WriteHead>
Mar 17 16:47:21 raspberrypi dockerd[734]: 2024/03/17 16:47:21 http: superfluous response.WriteHeader call from go.opentelemetry.io/contrib/instrumentation/net/http/otelhttp.(*respWriterWrapper).WriteHead>
Mar 17 16:47:22 raspberrypi dockerd[734]: 2024/03/17 16:47:22 http: superfluous response.WriteHeader call from go.opentelemetry.io/contrib/instrumentation/net/http/otelhttp.(*respWriterWrapper).WriteHead>
Mar 17 16:48:40 raspberrypi sudo[1766]:       pi : TTY=pts/3 ; PWD=/home/pi ; USER=root ; COMMAND=/usr/bin/nano /boot/firmware/config.txt
Mar 17 16:48:40 raspberrypi sudo[1766]: pam_unix(sudo:session): session opened for user root(uid=0) by pi(uid=1000)
Mar 17 16:50:02 raspberrypi sudo[1766]: pam_unix(sudo:session): session closed for user root
Mar 17 16:50:31 raspberrypi dockerd[734]: 2024/03/17 16:50:31 http: superfluous response.WriteHeader call from go.opentelemetry.io/contrib/instrumentation/net/http/otelhttp.(*respWriterWrapper).WriteHead>
Mar 17 16:50:33 raspberrypi dockerd[734]: 2024/03/17 16:50:33 http: superfluous response.WriteHeader call from go.opentelemetry.io/contrib/instrumentation/net/http/otelhttp.(*respWriterWrapper).WriteHead>
Mar 17 16:50:34 raspberrypi dockerd[734]: 2024/03/17 16:50:34 http: superfluous response.WriteHeader call from go.opentelemetry.io/contrib/instrumentation/net/http/otelhttp.(*respWriterWrapper).WriteHead>
Mar 17 16:50:40 raspberrypi dockerd[734]: 2024/03/17 16:50:40 http: superfluous response.WriteHeader call from go.opentelemetry.io/contrib/instrumentation/net/http/otelhttp.(*respWriterWrapper).WriteHead>
Mar 17 16:57:17 raspberrypi kernel: dwc2 3f980000.usb: dwc2_hc_chhltd_intr_dma: Channel 4 - ChHltd set, but reason is unknown
Mar 17 16:57:17 raspberrypi kernel: dwc2 3f980000.usb: hcint 0x00000402, intsts 0x06600009
Mar 17 16:57:17 raspberrypi kernel: dwc2 3f980000.usb: dwc2_hc_chhltd_intr_dma: Channel 2 - ChHltd set, but reason is unknown
Mar 17 16:57:17 raspberrypi kernel: dwc2 3f980000.usb: hcint 0x00000402, intsts 0x04600001
Mar 17 16:57:17 raspberrypi kernel: dwc2 3f980000.usb: dwc2_hc_chhltd_intr_dma: Channel 1 - ChHltd set, but reason is unknown
Mar 17 16:57:17 raspberrypi kernel: dwc2 3f980000.usb: hcint 0x00000402, intsts 0x04600001
```


Tried to removed getty

```
sudo systemctl stop getty@tty1.service
sudo systemctl disable getty@tty1.service
sudo systemctl stop serial-getty@ttyAMA0.service
sudo systemctl disable serial-getty@ttyAMA0.service
sudo systemctl mask serial-getty@ttyAMA0.service
sudo systemctl mask getty@tty.service
```


## cmdline.txt
```
sudo nano /boot/firmware/cmdline.txt
```

removed `console=tty1`

added on the existing line `dwc_otg.fiq_enable=0 dwc_otg.fiq_fsm_enable=0`

## config.txt

removed `dtoverlay=dwc2` from config.txt

Finally the py did not reboot....





