#!/usr/bin/env bash

# IMAGE="nvcr.io/nvidia/l4t-ml:r32.5.0-py3"
IMAGE="avatarify:dev"

xhost +

bash scripts/create_virtual_camera.sh

docker run --name avatarify -it --rm \
--runtime nvidia --network host \
--privileged \
--cap-add=ALL \
-e DISPLAY=":0" \
-v /tmp/.X11-unix/:/tmp/.X11-unix \
-v ${HOME}/.Xauthority:/root/.Xauthority \
-v /lib/modules:/lib/modules \
-v /dev:/dev \
-v ${HOME}/work/avatarify:/avatarify \
-v ${HOME}/work/avatarify/.face_alignment:/root/.cache/torch/hub/checkpoints/ \
--workdir /avatarify \
${IMAGE} \
bash -ic "./run.sh --no-conda"
