FROM ct2034/vnc-ros-kinetic-full

## use bash in RUN command.
SHELL ["/bin/bash", "-l", "-c"]

RUN apt-get update
RUN apt-get install protobuf-compiler libeigen3-dev libopencv-dev -y

# setup python3 virtual environment.
RUN apt-get install python3-venv -y
RUN python3 -m venv px4venv
RUN source px4venv/bin/activate

# download px4 firmware.
RUN git clone https://github.com/PX4/Firmware.git -b v1.8.0 --recursive
RUN pip install pip -U
RUN pip install jinja2 empy toml numpy
RUN bash Firmware/Tools/setup/ubuntu.sh

# install mavros.
RUN apt-get install ros-kinetic-mavros ros-kinetic-mavros-extras -y
RUN bash /opt/ros/kinetic/lib/mavros/install_geographiclib_datasets.sh
