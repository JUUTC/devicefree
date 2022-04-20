# syntax=docker/dockerfile:1
FROM ubuntu:18.04

WORKDIR /devicefree

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y --no-install-recommends 
RUN  apt-get install -y --no-install-recommends  build-essential
RUN  apt-get install -y --no-install-recommends  gcc-8 g++-8
RUN  apt-get install -y --no-install-recommends  ca-certificates
RUN  apt-get install -y --no-install-recommends  curl
RUN  apt-get install -y --no-install-recommends  ffmpeg
RUN  apt-get install -y --no-install-recommends  git
RUN  apt-get install -y --no-install-recommends  wget
RUN  apt-get install -y --no-install-recommends  unzip
RUN  apt-get install -y --no-install-recommends  python3-dev
RUN  apt-get install -y --no-install-recommends  python3-venv
RUN  apt-get install -y --no-install-recommends  python3-opencv
RUN  apt-get install -y --no-install-recommends  python3-pip
RUN  apt-get install -y --no-install-recommends  libopencv-core-dev
RUN  apt-get install -y --no-install-recommends  libopencv-highgui-dev
RUN  apt-get install -y --no-install-recommends  libopencv-imgproc-dev
RUN  apt-get install -y --no-install-recommends  libopencv-video-dev
RUN  apt-get install -y --no-install-recommends  libopencv-calib3d-dev
RUN  apt-get install -y --no-install-recommends  libopencv-features2d-dev
RUN  apt-get install -y --no-install-recommends  libx11-xcb-dev 
RUN  apt-get install -y --no-install-recommends  libglu1-mesa-dev
RUN  apt-get install -y --no-install-recommends  libxrender-dev
RUN  apt-get install -y --no-install-recommends  libxi-dev 
RUN  apt-get install -y --no-install-recommends  libxkbcommon-dev
RUN  apt-get install -y --no-install-recommends  libxkbcommon-x11-dev
RUN  apt-get install -y --no-install-recommends  nodejs
RUN  apt-get install -y --no-install-recommends  npm
RUN  apt-get install -y --no-install-recommends  apt-utils
RUN  apt-get install -y --no-install-recommends  software-properties-common 
RUN add-apt-repository -y ppa:openjdk-r/ppa 
RUN apt-get update && apt-get install -y openjdk-8-jdk 
RUN apt-get clean 
RUN mkdir -p /usr/local/lib/nodejs
RUN rm -rf /var/lib/apt/lists/*
#'^libxcb.*-dev' 

#RUN update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-8 100 --slave /usr/bin/g++ g++ /usr/bin/g++-8

RUN pip3 install --upgrade setuptools
RUN pip3 install wheel
RUN pip3 install future
RUN pip3 install six
RUN pip3 install tensorflow
#RUN pip3 install tensorflow==1.14.0
RUN python3 -m pip install --upgrade pip
RUN pip3 install scikit-build
RUN pip3 install cmake
RUN pip3 install opencv-python
RUN pip3 install tf_slim
RUN pip3 install deepface
RUN pip3 install numpy
RUN git clone https://github.com/google/mediapipe.git
RUN cd mediapipe
RUN apt-get install -y \
    libopencv-core-dev \
    libopencv-highgui-dev \
    libopencv-calib3d-dev \
    libopencv-features2d-dev \
    libopencv-imgproc-dev \
    libopencv-video-dev
#RUN pip3 mediapipe
RUN cd ..
RUN apt update
RUN apt upgrade -y
RUN npm install -g n
RUN npm i -g npx
#RUN npm install npm@latest -g npm
#RUN npx -p ring-client-api ring-device-data-cli
RUN rm -rf /tmp/pip-tmp
RUN rm -rf /var/lib/apt/lists/*
RUN rm -rf /var/cache/apt/archives/*


# start
COPY . /devicefree/
RUN cp check_face.service /etc/systemd/system/check_face.service.bak

ENTRYPOINT npx -p ring-client-api ring-device-data-cli
CMD ["systemctl", "start", "check_face.service"]
