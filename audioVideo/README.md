Pour lister les périphériques vidéo : 
```
ls /dev | grep video
```

# usb camera and command line

## installation des utilitaires v4l2

```
sudo apt install v4l-utils
```

lister les périphériques vidéo : 
```
v4l2-ctl --list-devices
```

Pour obtenir les caractéristiques du capteur : `v4l2-ctl --all` ou `v4l2-ctl -d 0 --all`
<details id=1>
<summary><i><b>exemple de sortie</b></i></summary>
	
```
Driver Info (not using libv4l2):
	Driver name   : uvcvideo
	Card type     : TOSHIBA Web Camera - FHD: TOSHI
	Bus info      : usb-0000:00:14.0-10
	Driver version: 5.4.119
	Capabilities  : 0x84A00001
		Video Capture
		Metadata Capture
		Streaming
		Extended Pix Format
		Device Capabilities
	Device Caps   : 0x04200001
		Video Capture
		Streaming
		Extended Pix Format
Priority: 2
Video input : 0 (Camera 1: ok)
Format Video Capture:
	Width/Height      : 1280/720
	Pixel Format      : 'YUYV'
	Field             : None
	Bytes per Line    : 2560
	Size Image        : 1843200
	Colorspace        : sRGB
	Transfer Function : Default (maps to sRGB)
	YCbCr/HSV Encoding: Default (maps to ITU-R 601)
	Quantization      : Default (maps to Limited Range)
	Flags             : 
Crop Capability Video Capture:
	Bounds      : Left 0, Top 0, Width 1280, Height 720
	Default     : Left 0, Top 0, Width 1280, Height 720
	Pixel Aspect: 1/1
Selection: crop_default, Left 0, Top 0, Width 1280, Height 720
Selection: crop_bounds, Left 0, Top 0, Width 1280, Height 720
Streaming Parameters Video Capture:
	Capabilities     : timeperframe
	Frames per second: 7.500 (15/2)
	Read buffers     : 0
                     brightness 0x00980900 (int)    : min=0 max=100 step=1 default=50 value=50
                       contrast 0x00980901 (int)    : min=0 max=100 step=1 default=32 value=32
                     saturation 0x00980902 (int)    : min=0 max=100 step=1 default=32 value=32
                            hue 0x00980903 (int)    : min=-4 max=4 step=1 default=0 value=0
 white_balance_temperature_auto 0x0098090c (bool)   : default=1 value=1
                          gamma 0x00980910 (int)    : min=1 max=16 step=1 default=8 value=8
           power_line_frequency 0x00980918 (menu)   : min=0 max=2 default=1 value=1
      white_balance_temperature 0x0098091a (int)    : min=2800 max=6500 step=10 default=5000 value=5000 flags=inactive
                      sharpness 0x0098091b (int)    : min=0 max=20 step=1 default=4 value=4
         backlight_compensation 0x0098091c (int)    : min=0 max=1 step=1 default=0 value=0
         exposure_auto_priority 0x009a0903 (bool)   : default=0 value=1
```
</details>

Pour le détail des formats de sortie : `v4l2-ctl -d /dev/video0 --list-formats-ext` :
<details id=2>
<summary><i><b>exemple de sortie</b></i></summary>

```
ioctl: VIDIOC_ENUM_FMT
	Index       : 0
	Type        : Video Capture
	Pixel Format: 'YUYV'
	Name        : YUYV 4:2:2
		Size: Discrete 640x480
			Interval: Discrete 0.033s (30.000 fps)
			Interval: Discrete 0.067s (15.000 fps)
			Interval: Discrete 0.033s (30.000 fps)
			Interval: Discrete 0.067s (15.000 fps)
		Size: Discrete 320x240
			Interval: Discrete 0.033s (30.000 fps)
			Interval: Discrete 0.067s (15.000 fps)
		Size: Discrete 320x180
			Interval: Discrete 0.033s (30.000 fps)
			Interval: Discrete 0.067s (15.000 fps)
		Size: Discrete 424x240
			Interval: Discrete 0.033s (30.000 fps)
			Interval: Discrete 0.067s (15.000 fps)
		Size: Discrete 640x360
			Interval: Discrete 0.033s (30.000 fps)
			Interval: Discrete 0.067s (15.000 fps)
		Size: Discrete 848x480
			Interval: Discrete 0.067s (15.000 fps)
		Size: Discrete 960x540
			Interval: Discrete 0.133s (7.500 fps)
		Size: Discrete 1280x720
			Interval: Discrete 0.133s (7.500 fps)
		Size: Discrete 1920x1080
			Interval: Discrete 0.200s (5.000 fps)
		Size: Discrete 640x480
			Interval: Discrete 0.033s (30.000 fps)
			Interval: Discrete 0.067s (15.000 fps)
			Interval: Discrete 0.033s (30.000 fps)
			Interval: Discrete 0.067s (15.000 fps)

	Index       : 1
	Type        : Video Capture
	Pixel Format: 'MJPG' (compressed)
	Name        : Motion-JPEG
		Size: Discrete 640x480
			Interval: Discrete 0.033s (30.000 fps)
			Interval: Discrete 0.067s (15.000 fps)
			Interval: Discrete 0.033s (30.000 fps)
			Interval: Discrete 0.067s (15.000 fps)
		Size: Discrete 320x240
			Interval: Discrete 0.033s (30.000 fps)
			Interval: Discrete 0.067s (15.000 fps)
		Size: Discrete 320x180
			Interval: Discrete 0.033s (30.000 fps)
			Interval: Discrete 0.067s (15.000 fps)
		Size: Discrete 424x240
			Interval: Discrete 0.033s (30.000 fps)
			Interval: Discrete 0.067s (15.000 fps)
		Size: Discrete 640x360
			Interval: Discrete 0.033s (30.000 fps)
			Interval: Discrete 0.067s (15.000 fps)
		Size: Discrete 848x480
			Interval: Discrete 0.033s (30.000 fps)
			Interval: Discrete 0.067s (15.000 fps)
		Size: Discrete 960x540
			Interval: Discrete 0.033s (30.000 fps)
			Interval: Discrete 0.067s (15.000 fps)
		Size: Discrete 1280x720
			Interval: Discrete 0.033s (30.000 fps)
			Interval: Discrete 0.067s (15.000 fps)
		Size: Discrete 1920x1080
			Interval: Discrete 0.033s (30.000 fps)
			Interval: Discrete 0.067s (15.000 fps)
		Size: Discrete 640x480
			Interval: Discrete 0.033s (30.000 fps)
			Interval: Discrete 0.067s (15.000 fps)
			Interval: Discrete 0.033s (30.000 fps)
			Interval: Discrete 0.067s (15.000 fps)
```
</details>

on s'apercoit que la caméra fait du 1280x720

pour capturer un frame :
```
v4l2-ctl --stream-mmap --stream-skip=1 --stream-to=frame.raw --stream-count=1
```
Pour transformer en png : ` convert -size 1280x720 uyvy:frame.raw frame.png`

![frame](https://user-images.githubusercontent.com/24553739/179963785-008b6be2-63fc-4d3e-a8a3-e82933e6b2da.png)

ou encore : `convert -size 1280x720 yuv:frame.raw frame1.png`

![frame1](https://user-images.githubusercontent.com/24553739/179963816-176d6484-6c27-4024-8956-a3c13539487b.png)

## ffmpeg

https://github.com/FFmpeg/FFmpeg

```
sudo apt  install ffmpeg
```
pour capturer un snapshot directement en jpg

```
ffmpeg -y -f v4l2 -video_size 1280x720 -i /dev/video0 -frames 1 out.jpg
```

![out](https://user-images.githubusercontent.com/24553739/179964204-8bcd4c7b-fa5c-48e7-8328-5cd45c0f6c6c.jpg)

## links

https://raspberrypi-guide.github.io/electronics/using-usb-webcams

https://doc.ubuntu-fr.org/webcam

https://github.com/csete/uvccapture

http://trac.gateworks.com/wiki/linux/v4l2

https://medium.com/@athul929/capture-an-image-using-v4l2-api-5b6022d79e1d

https://askubuntu.com/questions/348838/how-to-check-available-webcams-from-the-command-line

# to install non free codecs :
```
sudo apt install ubuntu-restricted-extras
```
# exemple of how to use google speech api

https://avroshk.com/diarization
