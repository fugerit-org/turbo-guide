# Create multi platform image with buildx

[index](index.md)

*Abstract* : Manually creates a multi platform image and push it with buildx

## 1. Configure the system

Install QEMU

`sudo apt-get install -y gcc-arm-linux-gnueabihf libc6-dev-armhf-cross qemu-user-static qemu-system-i386`

Create a build with docker-container driver

`docker buildx create --use --name multi-builder --driver docker-container --bootstrap`

## 2. Create and push the images

Docker login

`docker login`

Create and push the image, with multiple tags if needed

`docker buildx build --push -t ${TAG_V} -t ${TAG_L} --builder multi-builder --platform linux/arm64,linux/amd64 .`

This quickstart is based on : [https://www.docker.com/blog/multi-arch-build-and-images-the-simple-way/](https://www.docker.com/blog/multi-arch-build-and-images-the-simple-way/)