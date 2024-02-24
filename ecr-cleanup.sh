#!/bin/bash

# Define the prefix for the ECR repositories you want to delete
PREFIX="registry.k8s.io"

REPOS=$(aws ecr describe-repositories | jq -r '.repositories[] | select(.repositoryName | startswith("'"$PREFIX"'")) | .repositoryName')

# Loop through the filtered list and delete each repository
for repo in $REPOS; do
  echo "Deleting repository: $repo"
  aws ecr delete-repository --repository-name "$repo" --force
done

echo "All repositories starting with $PREFIX have been deleted."
