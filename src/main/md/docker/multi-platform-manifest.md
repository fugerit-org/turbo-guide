# Create multi platform manifest

[index](index.md)

*Abstract* : Manually creates a multi platform manifest (image) and push it to docker hub.

1. Crate and push the images for all the platform needed

For instance we will target linux/amd64 and linux/arm64 :

`docker build -t fugeritorg/fj-doc-playground-quarkus:3.1.5-linux-amd64 --platform linux/amd64 .`

`docker push fugeritorg/fj-doc-playground-quarkus:3.1.5-linux-amd64`

`docker build -t fugeritorg/fj-doc-playground-quarkus:3.1.5-linux-arm64 --platform linux/arm64 .`

`docker push fugeritorg/fj-doc-playground-quarkus:3.1.5-linux-arm64`

2. Create and push the multi platform manifest

```
docker manifest create \
fugeritorg/fj-doc-playground-quarkus:3.1.5 \
--amend fugeritorg/fj-doc-playground-quarkus:3.1.5-linux-amd64 \
--amend fugeritorg/fj-doc-playground-quarkus:3.1.5-linux-arm64 
```

`docker manifest push fugeritorg/fj-doc-playground-quarkus:3.1.5`

This quickstart is based on : [https://www.docker.com/blog/multi-arch-build-and-images-the-simple-way/](https://www.docker.com/blog/multi-arch-build-and-images-the-simple-way/)