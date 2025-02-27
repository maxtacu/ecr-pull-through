#!/bin/bash
# mkdir -p ./certificates && cd ./certificates
openssl genrsa -out ca.key 2048

openssl req -new -x509 -days 365 -key ca.key \
  -subj "/C=AU/CN=pull-through-webhook.kube-system.svc"\
  -out ca.crt

openssl req -newkey rsa:2048 -nodes -keyout server.key \
  -subj "/C=AU/CN=pull-through-webhook.kube-system.svc" \
  -out server.csr

openssl x509 -req \
  -extfile <(printf "subjectAltName=DNS:pull-through-webhook.kube-system.svc") \
  -days 365 \
  -in server.csr \
  -CA ca.crt -CAkey ca.key -CAcreateserial \
  -out server.crt

echo
echo ">> Generating kube secrets..."
kubectl -n kube-system delete secret pull-through-tls
kubectl -n kube-system create secret tls pull-through-tls \
  --cert=server.crt \
  --key=server.key \

CA=$(base64 -i ca.crt | tr '\n' ' ' | sed 's/ //g')

echo
echo ">> MutatingWebhookConfiguration caBundle: $CA"

if [[ "$(uname)" == "Darwin" ]]; then
    sed -i '' "s/REPLACEME/$CA/" bundle.yaml > bundle_modified.yaml
else
    sed -i "s/REPLACEME/$CA/" bundle.yaml > bundle_modified.yaml
fi

kubectl apply -f .

rm ca.crt ca.key ca.srl server.crt server.csr server.key bundle_modified.yaml

echo
echo "Pull Through mutation webhook is now installed."