general tutorial in Python

https://github.com/martinberoiz/daemon

or : https://martinberoiz.org/2019/03/10/how-to-write-systemd-daemons-using-python/

classics :

https://ensiwiki.ensimag.fr/images/e/eb/Makefile.pdf

https://ensiwiki.ensimag.fr/index.php?title=Makefile

https://opensource.com/article/18/8/what-how-makefile

https://krzysztofzuraw.com/blog/2016/makefiles-in-python-projects

https://medium.com/@habibdhif/simple-makefile-to-automate-python-projects-e233af7681ad

target notation

https://stackabuse.com/how-to-write-a-makefile-automating-python-setup-compilation-and-testing/

check which version of systemd is installed
```
pkg-config --modversion systemd
237
```
for more on pkg-config :

https://www.freedesktop.org/wiki/Software/pkg-config/

https://people.freedesktop.org/~dbn/pkg-config-guide.html

List all users and groups
```
cat /etc/passwd | awk -F: '{print $ 1}'
cat /etc/group | awk -F: '{print $ 1}'
```
