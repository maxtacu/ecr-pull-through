# Mutation webhook for ECR Pull-Through
The mutation webhook for ECR pull-through is a mechanism that intercepts requests to create or update pods in Kubernetes. It modifies the container image references in the pod specifications to use the ECR pull-through mechanism. This allows the pods to pull container images from the ECR registry through a local cache, improving performance and reducing network egress costs.

By using the mutation webhook, you can seamlessly integrate ECR pull-through into your Kubernetes cluster, ensuring that all pods automatically use the optimized image retrieval process.

### In case you want to configure it via kyverno
You can find Kyverno policies for quay.io, registry.k8s.io, ghcr.io in `kyverno` folder.
Unfortunately afaik for docker.io currently is not possible to properly develop a reliable policy.

## Additional docs for configuring Pull-Through will be added