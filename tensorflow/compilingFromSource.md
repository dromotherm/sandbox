# tf wheels

https://github.com/PINTO0309/Tensorflow-bin

https://giters.com/PINTO0309/Tensorflow-bin/issues/44

https://towardsdatascience.com/3-ways-to-install-tensorflow-2-on-raspberry-pi-fe1fa2da9104

https://github.com/bitsy-ai/tensorflow-arm-bin

https://www.tensorflow.org/install/source_rpi


# tf lite wheels

https://github.com/PINTO0309/TensorflowLite-bin

https://www.tensorflow.org/lite/guide/build_arm

# tensorflow compilation

## install docker

https://docs.docker.com/engine/install/ubuntu/

## compilation for version v2.4.0-rc2

```
git status
HEAD détachée sur v2.4.0-rc2
rien à valider, la copie de travail est propre
```
On lance la compilation
```
sudo chmod 666 /var/run/docker.sock
tensorflow/tools/ci_build/ci_build.sh PI-PYTHON37     tensorflow/tools/ci_build/pi/build_raspberry_pi.sh
```
compilation success :
```
WORKSPACE: /home/alexandrecuer/Documents/GitHub/tensorflow
CI_DOCKER_BUILD_EXTRA_PARAMS: 
CI_DOCKER_EXTRA_PARAMS: 
COMMAND: tensorflow/tools/ci_build/pi/build_raspberry_pi.sh
CI_COMMAND_PREFIX: ./tensorflow/tools/ci_build/builds/with_the_same_user ./tensorflow/tools/ci_build/builds/configured pi-python37
CONTAINER_TYPE: pi-python37
BUILD_TAG: tf_ci
  (docker container name will be tf_ci.pi-python37)

Building container (tf_ci.pi-python37)...
Sending build context to Docker daemon  983.6kB
Step 1/16 : FROM ubuntu:16.04
 ---> b6f507652425
Step 2/16 : LABEL maintainer="Terry Heo <terryheo@google.com>"
 ---> Using cache
 ---> 1d3ee0b6f303
Step 3/16 : ENV CI_BUILD_PYTHON=python3.7
 ---> Using cache
 ---> fbd5c56a88b8
Step 4/16 : ENV CROSSTOOL_PYTHON_INCLUDE_PATH=/usr/include/python3.7
 ---> Using cache
 ---> 4eaa30b296d3
Step 5/16 : COPY install/*.sh /install/
 ---> Using cache
 ---> 7bc3917eb044
Step 6/16 : RUN /install/install_bootstrap_deb_packages.sh
 ---> Using cache
 ---> 31a3466b4315
Step 7/16 : RUN add-apt-repository -y ppa:openjdk-r/ppa &&     add-apt-repository -y ppa:george-edison55/cmake-3.x
 ---> Using cache
 ---> 9e851dd2eedd
Step 8/16 : RUN /install/install_deb_packages.sh
 ---> Using cache
 ---> 11d40864288a
Step 9/16 : RUN /install/install_pi_python3x_toolchain.sh "3.7"
 ---> Using cache
 ---> 8701400ab920
Step 10/16 : RUN /install/install_bazel.sh
 ---> Using cache
 ---> 68b2b8daa075
Step 11/16 : RUN /install/install_proto3.sh
 ---> Using cache
 ---> 1d812e7a5747
Step 12/16 : RUN /install/install_buildifier.sh
 ---> Using cache
 ---> fa28399f86ee
Step 13/16 : RUN /install/install_auditwheel.sh
 ---> Using cache
 ---> 7ff6dfe3e81a
Step 14/16 : RUN /install/install_golang.sh
 ---> Using cache
 ---> e1cc93f4c5a9
Step 15/16 : COPY install/.bazelrc /etc/bazel.bazelrc
 ---> Using cache
 ---> 2f88266b403b
Step 16/16 : ENV TF_ENABLE_XLA=0
 ---> Using cache
 ---> fc5c6e354999
Successfully built fc5c6e354999
Successfully tagged tf_ci.pi-python37:latest
Running 'tensorflow/tools/ci_build/pi/build_raspberry_pi.sh' inside tf_ci.pi-python37...
Reading package lists...
Building dependency tree...
Reading state information...
sudo is already the newest version (1.8.16-0ubuntu1.10).
0 upgraded, 0 newly installed, 0 to remove and 0 not upgraded.
Adding group `alexandrecuer' (GID 1000) ...
Done.
/workspace /workspace
You have bazel 3.1.0 installed.
Found possible Python library paths:
  /usr/local/lib/python3.7/dist-packages
  /usr/lib/python3/dist-packages
Please input the desired Python library path to use.  Default is [/usr/local/lib/python3.7/dist-packages]
Do you wish to build TensorFlow with ROCm support? [y/N]: No ROCm support will be enabled for TensorFlow.

Do you wish to build TensorFlow with CUDA support? [y/N]: No CUDA support will be enabled for TensorFlow.

Do you wish to download a fresh release of clang? (Experimental) [y/N]: Clang will not be downloaded.

Please specify optimization flags to use during compilation when bazel option "--config=opt" is specified [Default is -march=native -Wno-sign-compare]: 

Would you like to interactively configure ./WORKSPACE for Android builds? [y/N]: Not configuring the WORKSPACE for Android builds.

Preconfigured Bazel build configs. You can use any of the below by adding "--config=<>" to your build command. See .bazelrc for more details.
	--config=mkl         	# Build with MKL support.
	--config=mkl_aarch64 	# Build with oneDNN support for Aarch64.
	--config=monolithic  	# Config for mostly static monolithic build.
	--config=ngraph      	# Build with Intel nGraph support.
	--config=numa        	# Build with NUMA support.
	--config=dynamic_kernels	# (Experimental) Build kernels into separate shared objects.
	--config=v2          	# Build TensorFlow 2.x instead of 1.x.
Preconfigured Bazel build configs to DISABLE default on features:
	--config=noaws       	# Disable AWS S3 filesystem support.
	--config=nogcp       	# Disable GCP support.
	--config=nohdfs      	# Disable HDFS support.
	--config=nonccl      	# Disable NVIDIA NCCL support.
/workspace
TF_BUILD_INFO = {container_type: "pi-python37", command: "tensorflow/tools/ci_build/pi/build_raspberry_pi.sh", source_HEAD: "0b06f2927be226ffe44f47bfa9e03e4ea649d7f3", source_remote_origin: "https://github.com/tensorflow/tensorflow.git", OS: "Linux", kernel: "5.11.0-44-generic", architecture: "x86_64", processor: "Intel(R) Core(TM) i7-7700HQ CPU @ 2.80GHz", processor_count: "8", memory_total: "16142828 kB", swap_total: "2097148 kB", Bazel_version: "Build label: 3.1.0", Java_version: "1.8.0_292", Python_version: "2.7.12", gpp_version: "g++ (Ubuntu 5.4.0-6ubuntu1~16.04.12) 5.4.0 20160609", swig_version: "", NVIDIA_driver_version: "470.86", CUDA_device_count: "0", CUDA_device_names: "", CUDA_toolkit_version: ""}
You have bazel 3.1.0 installed.
Found possible Python library paths:
  /usr/local/lib/python3.7/dist-packages
  /usr/lib/python3/dist-packages
Please input the desired Python library path to use.  Default is [/usr/local/lib/python3.7/dist-packages]
Do you wish to build TensorFlow with ROCm support? [y/N]: No ROCm support will be enabled for TensorFlow.

Do you wish to build TensorFlow with CUDA support? [y/N]: No CUDA support will be enabled for TensorFlow.

Do you wish to download a fresh release of clang? (Experimental) [y/N]: Clang will not be downloaded.

Please specify optimization flags to use during compilation when bazel option "--config=opt" is specified [Default is -march=native -Wno-sign-compare]: 

Would you like to interactively configure ./WORKSPACE for Android builds? [y/N]: Not configuring the WORKSPACE for Android builds.

Preconfigured Bazel build configs. You can use any of the below by adding "--config=<>" to your build command. See .bazelrc for more details.
	--config=mkl         	# Build with MKL support.
	--config=mkl_aarch64 	# Build with oneDNN support for Aarch64.
	--config=monolithic  	# Config for mostly static monolithic build.
	--config=ngraph      	# Build with Intel nGraph support.
	--config=numa        	# Build with NUMA support.
	--config=dynamic_kernels	# (Experimental) Build kernels into separate shared objects.
	--config=v2          	# Build TensorFlow 2.x instead of 1.x.
Preconfigured Bazel build configs to DISABLE default on features:
	--config=noaws       	# Disable AWS S3 filesystem support.
	--config=nogcp       	# Disable GCP support.
	--config=nohdfs      	# Disable HDFS support.
	--config=nonccl      	# Disable NVIDIA NCCL support.
Configuration finished
Building for the Pi Two/Three, with NEON acceleration
INFO: Options provided by the client:
  Inherited 'common' options: --isatty=0 --terminal_columns=80
INFO: Reading rc options for 'build' from /etc/bazel.bazelrc:
  Inherited 'common' options: --color=yes
INFO: Reading rc options for 'build' from /workspace/.bazelrc:
  Inherited 'common' options: --experimental_repo_remote_exec
INFO: Reading rc options for 'build' from /etc/bazel.bazelrc:
  'build' options: --verbose_failures --spawn_strategy=standalone --strategy=Genrule=standalone
INFO: Reading rc options for 'build' from /workspace/.bazelrc:
  'build' options: --apple_platform_type=macos --define framework_shared_object=true --define open_source_build=true --java_toolchain=//third_party/toolchains/java:tf_java_toolchain --host_java_toolchain=//third_party/toolchains/java:tf_java_toolchain --define=tensorflow_enable_mlir_generated_gpu_kernels=0 --define=use_fast_cpp_protos=true --define=allow_oversize_protos=true --spawn_strategy=standalone -c opt --announce_rc --define=grpc_no_ares=true --noincompatible_remove_legacy_whole_archive --noincompatible_prohibit_aapt1 --enable_platform_specific_config --config=short_logs --config=v2
INFO: Reading rc options for 'build' from /workspace/.tf_configure.bazelrc:
  'build' options: --action_env PYTHON_BIN_PATH=/usr/local/bin/python3.7 --action_env PYTHON_LIB_PATH=/usr/local/lib/python3.7/dist-packages --python_path=/usr/local/bin/python3.7 --action_env TF_CONFIGURE_IOS=0
INFO: Found applicable config definition build:short_logs in file /workspace/.bazelrc: --output_filter=DONT_MATCH_ANYTHING
INFO: Found applicable config definition build:v2 in file /workspace/.bazelrc: --define=tf_api_version=2 --action_env=TF2_BEHAVIOR=1
INFO: Found applicable config definition build:monolithic in file /workspace/.bazelrc: --define framework_shared_object=false
INFO: Found applicable config definition build:linux in file /workspace/.bazelrc: --copt=-w --host_copt=-w --define=PREFIX=/usr --define=LIBDIR=$(PREFIX)/lib --define=INCLUDEDIR=$(PREFIX)/include --define=PROTOBUF_INCLUDE_PATH=$(PREFIX)/include --cxxopt=-std=c++14 --host_cxxopt=-std=c++14 --config=dynamic_kernels
INFO: Found applicable config definition build:dynamic_kernels in file /workspace/.bazelrc: --define=dynamic_loaded_kernels=true --copt=-DAUTOLOAD_DYNAMIC_KERNELS
Loading: 
Loading: 0 packages loaded
Loading: 0 packages loaded
Analyzing: 4 targets (3 packages loaded)
Analyzing: 4 targets (3 packages loaded, 0 targets configured)
Analyzing: 4 targets (62 packages loaded, 39 targets configured)
Analyzing: 4 targets (134 packages loaded, 1610 targets configured)
Analyzing: 4 targets (206 packages loaded, 4212 targets configured)
Analyzing: 4 targets (267 packages loaded, 6035 targets configured)
Analyzing: 4 targets (348 packages loaded, 10265 targets configured)
Analyzing: 4 targets (364 packages loaded, 15894 targets configured)
Analyzing: 4 targets (396 packages loaded, 21144 targets configured)
Analyzing: 4 targets (403 packages loaded, 31497 targets configured)
INFO: Analyzed 4 targets (403 packages loaded, 35482 targets configured).

INFO: Found 4 targets...
INFO: Deleting stale sandbox base /home/alexandrecuer/Documents/GitHub/tensorflow/bazel-ci_build-cache/.cache/bazel/_bazel_alexandrecuer/eab0d61a99b6696edb3d2aff87b585e8/sandbox
[0 / 1,636] [Prepa] BazelWorkspaceStatusAction stable-status.txt ... (2 actions, 0 running)
[211 / 3,190] [Prepa] Writing file tensorflow/core/platform/libcpu_feature_guard.a-2.params [for host]
[325 / 3,330] Compiling external/fft2d/fftsg2d.c [for host]; 3s local ... (8 actions running)
[404 / 3,508] Compiling tensorflow/lite/kernels/internal/quantization_util.cc [for host]; 0s local ... (4 actions running)
[657 / 4,015] Compiling external/ruy/ruy/trmul.cc [for host]; 0s local ... (7 actions running)
[1,367 / 7,117] Compiling external/fft2d/fftsg.c; 0s local ... (5 actions, 2 running)
[1,948 / 9,129] Compiling external/flatbuffers/src/code_generators.cpp; 1s local ... (8 actions running)
[2,369 / 12,979] Compiling external/flatbuffers/src/idl_parser.cpp; 7s local
[3,327 / 16,392] checking cached actions
[3,692 / 17,246] Compiling external/org_sqlite/sqlite3.c; 3s local ... (8 actions, 7 running)
[3,786 / 17,246] Compiling external/org_sqlite/sqlite3.c; 12s local ... (8 actions, 7 running)
[3,865 / 17,246] [Prepa] Writing file tensorflow/tools/pip_package/xla_compiled_cpu_runtime_srcs.txt
[3,965 / 17,545] Compiling external/com_google_absl/absl/hash/internal/city.cc [for host]; 0s local ... (8 actions, 7 running)
[4,206 / 17,545] Compiling external/com_google_absl/absl/strings/numbers.cc; 1s local ... (8 actions, 7 running)
[4,458 / 17,545] [Scann] Compiling external/upb/upb/decode.c
[4,662 / 17,545] Compiling tensorflow/compiler/xla/service/cpu/runtime_single_threaded_matmul.cc; 14s local ... (8 actions, 7 running)
[5,061 / 17,545] Compiling external/com_google_protobuf/src/google/protobuf/descriptor.cc; 9s local ... (8 actions, 7 running)
[5,426 / 17,545] Compiling external/boringssl/src/ssl/handshake_client.cc; 1s local ... (8 actions, 7 running)
[5,778 / 17,545] Compiling external/com_github_grpc_grpc/src/core/ext/transport/chttp2/transport/hpack_parser.cc; 1s local ... (8 actions, 7 running)
[7,795 / 25,235] Action tensorflow/lite/python/schema_py_generated.py; 0s local ... (3 actions, 1 running)
[8,353 / 25,639] Compiling tensorflow/core/profiler/protobuf/steps_db.pb.cc; 5s local ... (8 actions, 7 running)
[8,736 / 25,639] Compiling tensorflow/core/protobuf/config.pb.cc; 8s local ... (8 actions, 7 running)
[9,035 / 25,639] Compiling tensorflow/core/protobuf/config.pb.cc [for host]; 9s local ... (8 actions, 7 running)
[10,096 / 25,639] Compiling external/com_github_grpc_grpc/src/core/lib/security/credentials/composite/composite_credentials.cc; 2s local ... (8 actions, 7 running)
[11,046 / 25,639] Compiling external/aws/aws-cpp-sdk-s3/source/S3Client.cpp; 8s local ... (8 actions, 7 running)
[11,516 / 25,639] Compiling external/llvm-project/llvm/lib/DebugInfo/CodeView/EnumTables.cpp; 11s local ... (8 actions, 7 running)
[12,097 / 25,639] Compiling tensorflow/lite/toco/tflite/types.cc; 4s local ... (8 actions, 7 running)
[12,454 / 25,639] Compiling tensorflow/lite/kernels/conv.cc; 9s local ... (8 actions, 7 running)
[12,917 / 25,639] Compiling external/aws/aws-cpp-sdk-s3/source/S3Client.cpp; 23s local ... (8 actions running)
[13,595 / 25,639] Compiling external/llvm-project/llvm/lib/Support/VirtualFileSystem.cpp; 4s local ... (8 actions running)
[14,524 / 25,639] Compiling external/llvm-project/llvm/lib/Analysis/DomTreeUpdater.cpp; 3s local ... (8 actions running)
[14,762 / 25,639] Compiling external/llvm-project/llvm/lib/CodeGen/CommandFlags.cpp; 5s local ... (8 actions running)
[15,001 / 25,639] Compiling external/llvm-project/llvm/lib/CodeGen/SelectionDAG/DAGCombiner.cpp; 18s local ... (8 actions running)
[16,159 / 25,639] Compiling tensorflow/compiler/mlir/lite/ir/tfl_ops.cc; 10s local ... (8 actions running)
[16,504 / 25,639] Compiling tensorflow/compiler/mlir/hlo/lib/Dialect/mhlo/IR/lhlo_ops.cc; 31s local ... (8 actions running)
[16,868 / 25,639] Compiling external/llvm-project/llvm/lib/Analysis/ScalarEvolution.cpp; 18s local ... (8 actions running)
[17,264 / 25,639] Compiling external/llvm-project/llvm/lib/CodeGen/XRayInstrumentation.cpp; 8s local ... (8 actions running)
[18,471 / 25,639] Compiling tensorflow/compiler/mlir/tensorflow/ir/tf_ops_n_z.cc; 76s local ... (8 actions running)
[19,335 / 25,639] Compiling tensorflow/core/kernels/gather_op.cc; 29s local ... (8 actions, 7 running)
[19,620 / 25,639] Compiling tensorflow/core/kernels/conv_grad_filter_ops.cc; 35s local ... (8 actions, 7 running)
[19,946 / 25,639] Compiling tensorflow/compiler/mlir/xla/mlir_hlo_to_hlo.cc; 19s local ... (8 actions running)
[20,755 / 25,639] Compiling tensorflow/python/tfe_wrapper.cc; 12s local ... (8 actions running)
[22,201 / 25,639] Compiling tensorflow/core/kernels/data/sparse_tensor_slice_dataset_op.cc; 7s local ... (8 actions running)
[23,694 / 25,639] Compiling tensorflow/core/kernels/linalg/matrix_square_root_op.cc; 124s local ... (8 actions running)
[24,452 / 25,639] Compiling tensorflow/compiler/tf2xla/kernels/xla_svd_op.cc; 13s local ... (8 actions running)
[27,221 / 27,833] Linking tensorflow/python/_pywrap_tensorflow_internal.so; 530s local ... (8 actions running)
INFO: Elapsed time: 10206.262s, Critical Path: 1458.67s
INFO: 16665 processes: 16665 local.
INFO: Build completed successfully, 19637 total actions
INFO: Build completed successfully, 19637 total actions
Final outputs will go to output-artifacts
Sat Jan 8 00:20:06 UTC 2022 : === Preparing sources in dir: /tmp/tmp.FB2MMc4KsS
/workspace /workspace
/workspace
/workspace/bazel-bin/tensorflow/tools/pip_package/build_pip_package.runfiles/org_tensorflow /workspace
/workspace
/tmp/tmp.FB2MMc4KsS/tensorflow/include /workspace
/workspace
Sat Jan 8 00:20:42 UTC 2022 : === Building wheel
warning: no files found matching 'README'
warning: no files found matching '*.pyd' under directory '*'
warning: no files found matching '*.pyi' under directory '*'
warning: no files found matching '*.pd' under directory '*'
warning: no files found matching '*.so.[0-9]' under directory '*'
warning: no files found matching '*.dylib' under directory '*'
warning: no files found matching '*.dll' under directory '*'
warning: no files found matching '*.lib' under directory '*'
warning: no files found matching '*.csv' under directory '*'
warning: no files found matching '*.h' under directory 'tensorflow/include/tensorflow'
warning: no files found matching '*.proto' under directory 'tensorflow/include/tensorflow'
warning: no files found matching '*' under directory 'tensorflow/include/third_party'
/usr/local/lib/python3.7/dist-packages/setuptools/command/install.py:37: SetuptoolsDeprecationWarning: setup.py install is deprecated. Use build and pip and other standards-based tools.
  setuptools.SetuptoolsDeprecationWarning,
Sat Jan 8 00:21:25 UTC 2022 : === Output wheel file is in: /workspace/output-artifacts
Output can be found here:
output-artifacts
output-artifacts/libtensorflow_framework.so
output-artifacts/benchmark_model
output-artifacts/tensorflow-2.4.0rc2-cp37-none-linux_armv7l.whl
output-artifacts/libtensorflow.so
```
