# Mutation webhook for ECR Pull-Through
The mutation webhook for ECR pull-through is a mechanism that intercepts requests to create or update pods in Kubernetes. It modifies the container image references in the pod specifications to use the ECR pull-through mechanism. This allows the pods to pull container images from the ECR registry through a local cache, improving performance and reducing network egress costs.

By using the mutation webhook, you can seamlessly integrate ECR pull-through into your Kubernetes cluster, ensuring that all pods automatically use the optimized image retrieval process.

## Prerequisite
Before you begin, you must manually create a Pull Through cache configuration for ghcr.io, docker.io, registry.k8s.io, and quay.io, using names that are similar. At the time of writing, it is not possible to automate this process via Terraform, so manual setup is required, along with the creation of "Creation templates."   
An example of how it should look is provided here: ![](image.png)
Bonus (optional): Within the `aws` folder, you'll find an example lifecycle policy that can be utilized in your "Creation Templates" and an example ECR Registry policy. This policy is necessary to allow EKS to create new repositories with images that are pulled through ECR.
 
## Configuration via Kyverno
For those who prefer to configure using Kyverno, policies for quay.io, registry.k8s.io, and ghcr.io are available in the `kyverno` folder.  
Currently, due to some limitations with Kyverno, it has not been possible to develop a reliable policy for `docker.io`. In this case, the mutation webhook comes handy.  
**Don't forget to update the AWS account ID inside the Kyverno policies before applying.**

## Additional docs for configuring Pull-Through will be added