https://ensiwiki.ensimag.fr/images/e/eb/Makefile.pdf

https://opensource.com/article/18/8/what-how-makefile

https://krzysztofzuraw.com/blog/2016/makefiles-in-python-projects

https://medium.com/@habibdhif/simple-makefile-to-automate-python-projects-e233af7681ad

check which version of systemd is installed
```
pkg-config --modversion systemd
237
```

List all users and groups
```
cat /etc/passwd | awk -F: '{print $ 1}'
cat /etc/group | awk -F: '{print $ 1}'
```
