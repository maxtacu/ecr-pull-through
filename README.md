# Mutation webhook for ECR Pull-Through
The mutation webhook for ECR pull-through is a mechanism that intercepts requests to create or update pods in Kubernetes. It modifies the container image references in the pod specifications to use the ECR pull-through mechanism. This allows the pods to pull container images from the ECR registry through a local cache, improving performance and reducing network egress costs.

By using the mutation webhook, you can seamlessly integrate ECR pull-through into your Kubernetes cluster, ensuring that all pods automatically use the optimized image retrieval process.

## Prerequisite
You should create Pull Through cache configuration for ghcr.io, docker.io, registry.k8s.io, quay.io with similar names. At the moment of writing it is not possible to create it via terraform, so you should do it manually. 
It should look like here: ![](image.png)

### In case you want to configure it via kyverno
You can find Kyverno policies for quay.io, registry.k8s.io, ghcr.io in `kyverno` folder.
Unfortunately at the moment of writing I didnt find a way to develop a reliable kyverno policy for `docker.io` due to some kyverno limitations. Here the mutation webhook comes handy.

## Additional docs for configuring Pull-Through will be added