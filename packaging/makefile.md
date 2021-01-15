## makefile

https://www.gnu.org/software/make/manual/

makefile are all about target notation

https://stackabuse.com/how-to-write-a-makefile-automating-python-setup-compilation-and-testing/

```
target: prerequisites
<TAB> recipe
```
to create a file in a target :
```
test:
  @sudo mkdir /lib/systemd/system/$(service_file_name).d
  @echo "[Service]\nUser=\"$(user)\"" > $(user).conf
  @sudo mv $(user).conf /lib/systemd/system/$(service_file_name).d/$(user).conf
```

using if in targets : NO TAB for @if and fi !! they must start at column 1
```
prepare:
@if [ ! -d $(conf_dir) ]; then\
  sudo mkdir $(conf_dir);\
  sudo cp params.conf $(conf_dir)/params.conf;\
fi
```

### general tutorial in Python

https://github.com/martinberoiz/daemon

or : https://martinberoiz.org/2019/03/10/how-to-write-systemd-daemons-using-python/

interesting : using setup.py to create a sort of daemon. Anyway, does not seem to be very robust

the makefile is too complex, using awk to work on files.....

### classic C makefiles

https://ensiwiki.ensimag.fr/images/e/eb/Makefile.pdf

https://ensiwiki.ens#imag.fr/index.php?title=Makefile

https://opensource.com/article/18/8/what-how-makefile

### some pythonic approaches
https://krzysztofzuraw.com/blog/2016/makefiles-in-python-projects

https://medium.com/@habibdhif/simple-makefile-to-automate-python-projects-e233af7681ad

