# ECR Pull-Through Cache Mutation Webhook 🚀

A Kubernetes mutation webhook that automatically redirects container image pulls through Amazon ECR's pull-through cache, optimizing performance and reducing costs.

## 🎯 What It Does

This webhook intercepts pod creation requests in your Kubernetes cluster and automatically modifies container image references to use Amazon ECR's pull-through cache. This means:

- ⚡ Faster image pulls through local caching
- 💰 Reduced network egress costs
- 🔄 Seamless integration with existing deployments

## 🚦 Prerequisites

1. **ECR Pull-Through Cache Configuration**
   You must manually configure pull-through cache for these registries:
   - `ghcr.io`
   - `docker.io`
   - `registry.k8s.io`
   - `quay.io`

   > ⚠️ **Important**: Use registry-matching names for your configurations as required by this webhook.

   Example configuration:
   ![ECR Pull-Through Configuration](image.png)

2. **IAM Configuration**
   Check the `aws-policies` folder for:
   - Example lifecycle policies for Creation Templates
   - ECR Registry policy examples
   - Role configurations for EKS nodes

📚 For detailed ECR Pull-Through setup, see the [AWS documentation](https://docs.aws.amazon.com/AmazonECR/latest/userguide/pull-through-cache.html#pull-through-cache-iam).

## 🛠️ Installation Options

### Option 1: Kyverno Policies

> Note: docker.io support is limited in Kyverno configuration

1. Find policies for `quay.io`, `registry.k8s.io`, and `ghcr.io` in the `kyverno` folder
2. Update AWS account ID in policies
3. Apply to your cluster

### Option 2: Mutation Webhook

1. Clone this repository
2. Configure [manifests/configmap.yaml](manifests/configmap.yaml)
3. Ensure your kubectl context points to the target cluster
4. Run `./install.sh`

> 🔑 **Note**: By default, the webhook only processes namespaces labeled with `pull-through-enabled: "true"`. Modify [manifests/bundle.yaml](manifests/bundle.yaml) to change this behavior.

## 🧪 Testing

Use the sample pod manifests in the `tests` folder to verify the webhook's operation.

## 🧹 Maintenance

### ECR Repository Cleanup
Use [ecr-cleanup.sh](ecr-cleanup.sh) to remove pull-through generated repositories:
```bash
./ecr-cleanup.sh
```

## 📝 Contributing

Contributions are welcome! Especially for improving Kyverno support for `docker.io`.

## 📄 License

This project is open-source and available under the MIT License.