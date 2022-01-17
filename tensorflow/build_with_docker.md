pour lister les images docker sur un système
```
docker image ls
REPOSITORY          TAG       IMAGE ID       CREATED        SIZE
tf_ci.pi-python38   latest    ea16632aa9a3   34 hours ago   2.42GB
<none>              <none>    b8d1f060839e   2 days ago     2.37GB
<none>              <none>    003ba125db8f   8 days ago     1.13GB
tf_ci.pi-python37   latest    fc5c6e354999   9 days ago     2.22GB
<none>              <none>    e343656b4760   10 days ago    1.05GB
<none>              <none>    3212335abebd   10 days ago    2.43GB
alex_aarch64        latest    b1f4070f8b10   10 days ago    2.42GB
tf_ci.pi-python39   latest    b1f4070f8b10   10 days ago    2.42GB
hello-world         latest    feb5d9fea6a5   3 months ago   13.3kB
ubuntu              16.04     b6f507652425   4 months ago   135MB
```
pour construire une image à partir d'un dockerfile :

```
docker build -t alex_aarch64 -f tensorflow/tools/ci_build/Dockerfile.pi-python39 tensorflow/tools/ci_build
Sending build context to Docker daemon  905.2kB
Step 1/18 : FROM ubuntu:16.04
 ---> b6f507652425
Step 2/18 : LABEL maintainer="Katsuya Hyodo <rmsdh122@yahoo.co.jp>"
 ---> Using cache
 ---> 3905b4b78a69
Step 3/18 : ENV CI_BUILD_PYTHON=python3.9
 ---> Using cache
 ---> 74fd6b2d7c59
Step 4/18 : ENV CROSSTOOL_PYTHON_INCLUDE_PATH=/usr/include/python3.9
 ---> Using cache
 ---> 2e607f61fd48
Step 5/18 : COPY install/*.sh /install/
 ---> Using cache
 ---> 2290963435f2
Step 6/18 : RUN /install/install_bootstrap_deb_packages.sh
 ---> Using cache
 ---> 6ea9b3d1732c
Step 7/18 : RUN add-apt-repository -y ppa:openjdk-r/ppa
 ---> Using cache
 ---> f27a442b545f
Step 8/18 : RUN /install/install_deb_packages.sh --without_cmake
 ---> Using cache
 ---> 21b03dad50ce
Step 9/18 : RUN /install/install_cmake.sh
 ---> Using cache
 ---> 45b1dee37b2f
Step 10/18 : RUN /install/install_pi_python3x_toolchain.sh "3.9"
 ---> Using cache
 ---> 137468976284
Step 11/18 : RUN /install/install_bazel.sh
 ---> Using cache
 ---> 8ec2c7ddb5ca
Step 12/18 : RUN /install/install_proto3.sh
 ---> Using cache
 ---> a5538ec0be60
Step 13/18 : RUN /install/install_buildifier.sh
 ---> Using cache
 ---> a712cb1f270c
Step 14/18 : RUN /install/install_auditwheel.sh
 ---> Using cache
 ---> b66c07bc2eda
Step 15/18 : RUN /install/install_golang.sh
 ---> Using cache
 ---> 56a0927e12b6
Step 16/18 : COPY install/.bazelrc /etc/bazel.bazelrc
 ---> Using cache
 ---> 9ea29c81d4af
Step 17/18 : RUN chmod 644 /etc/bazel.bazelrc
 ---> Using cache
 ---> 87ec257f4a55
Step 18/18 : ENV TF_ENABLE_XLA=0
 ---> Using cache
 ---> b1f4070f8b10
Successfully built b1f4070f8b10
Successfully tagged alex_aarch64:latest
```
