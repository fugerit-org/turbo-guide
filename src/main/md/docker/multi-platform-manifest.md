# Create multi platform manifest

[index](index.md)

*Abstract* : Manually creates a multi platform manifest (image) and push it to docker hub.

1. Crate and push the images for all the platform needed

For instance we will target linux/amd64 and linux/arm64 :

`docker build -t fugeritorg/fj-doc-playground-quarkus:3.1.5-linux-amd64 --platform linux/amd64 .`

`docker push fugeritorg/fj-doc-playground-quarkus:3.1.5-linux-amd64`

`docker build -t fugeritorg/fj-doc-playground-quarkus:3.1.5-linux-arm64 --platform linux/arm64 .`

`docker push fugeritorg/fj-doc-playground-quarkus:3.1.5-linux-arm64`

2A. Create and push the multi platform manifest

```
docker manifest create \
fugeritorg/fj-doc-playground-quarkus:3.1.5 \
--amend fugeritorg/fj-doc-playground-quarkus:3.1.5-linux-amd64 \
--amend fugeritorg/fj-doc-playground-quarkus:3.1.5-linux-arm64 
```

`docker manifest push fugeritorg/fj-doc-playground-quarkus:3.1.5`

This quickstart is based on : [https://www.docker.com/blog/multi-arch-build-and-images-the-simple-way/](https://www.docker.com/blog/multi-arch-build-and-images-the-simple-way/)

2B. Create and push the multi platform with buildx

Depending on you system, method 2A could not work with message "${your manifest} is a manifest list"

It is possible to use buildx to build a new image from the two created : 

```
docker buildx imagetools create -t fugeritorg/quarkus-photobook:v1.0.0-native \
    fugeritorg/quarkus-photobook:v1.0.0-arm64native  \
    fugeritorg/quarkus-photobook:v1.0.0-amd64native
```

This solution was borrowed from : 

<https://stackoverflow.com/questions/75521775/buildx-docker-image-claims-to-be-a-manifest-list>