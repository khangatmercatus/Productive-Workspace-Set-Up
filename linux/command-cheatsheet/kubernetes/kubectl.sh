## Get custom columns/values of Node
# Get capacity info
kubectl get nodes -o custom-columns='NODE NAME:.metadata.name,CPU_CORES:.status.capacity.cpu,ALLOC_CPU:.status.allocatable.cpu,ALLOC_EPHEMERAL_STORAGE:.status.allocatable.ephemeral-storage,ALLOC_MEM:.status.allocatable.memory,MAX_POD:.status.allocatable.pods'
# Get timestamp info
kubectl get nodes -o custom-columns='NODE NAME:.metadata.name,CREATED_AT:.metadata.creationTimestamp,LAST_HEALTHY:.status.conditions[0].lastHeartbeatTime'
# Get address info
kubectl get nodes -o custom-columns='NODE NAME:.metadata.name,HOST_TYPE:.status.addresses.*.type,ADDRESSES:.status.addresses.*.address'
# Get OS-level info
kubectl get nodes -o custom-columns='NODE NAME:.metadata.name,ARCHITECTURE:.status.nodeInfo.architecture,CONTAINER_RUNTIME:.status.nodeInfo.containerRuntimeVersion,KERNEL_VER:.status.nodeInfo.kernelVersion,OS:.status.nodeInfo.osImage'


# Get downloaded/existing images and corresponding one version of tag
kubectl get node aks-heavy9d45-26308833-vmss000000 -o jsonpath='{.status.images.*.names[0]}' |  tr ' ' '\n'
# Get downloaded/existing images
kubectl get node aks-heavy9d45-26308833-vmss000000 -o jsonpath='{.status.images.*.names[0]}' |  tr ' ' '\n' | cut -d ':' -f1

## Get custom columns/values of Pod
# Get timestamp info
kubectl get pods -o custom-columns='POD NAME:.metadata.name,CREATED_AT:.metadata.creationTimestamp,NAMESPACE:.metadata.namespace'
# Get controlling resources
kubectl get pods -o custom-columns='POD NAME:.metadata.name,CONTROLLED_BY:.metadata.ownerReferences[0].kind,NAMESPACE:.metadata.namespace'
# Get custome values
kubectl get pod <POD_NAME> -o custom-columns='POD NAME:.metadata.name,CONTROLLED_BY:.spec.containers[0].env.*,NAMESPACE:.metadata.namespace,NAMESPACE:.metadata.namespace'
kubectl get pod <POD_NAME> -o custom-columns='POD NAME:.metadata.name,ENVIRONMENT_VAR:.spec.containers[0].env.*.name,NAMESPACE:.metadata.namespace'
kubectl get pods -o custom-columns='POD NAME:.metadata.name,IMAGE:.spec.containers[0].image,PULL_POLICY:.spec.containers[0].imagePullPolicy,NAMESPACE:.metadata.namespace'
kubectl get pods -o custom-columns='POD NAME:.metadata.name,CONTAINER_PORT:.spec.containers[0].ports.*.containerPort,NAMESPACE:.metadata.namespace'
kubectl get pods -o custom-columns='POD NAME:.metadata.name,REQUEST_CPU:.spec.containers[0].resources.requests.cpu,LIMIT_CPU:.spec.containers[0].resources.limits.cpu,REQUEST_MEM:.spec.containers[0].resources.requests.memory,LIMIT_MEM:.spec.containers[0].resources.limits.memory,REQUEST_EPHEMERAL_STORAGE:.spec.containers[0].resources.requests.ephemeral-storage,LIMIT_EPHEMERAL_STORAGE:.spec.containers[0].resources.limits.ephemeral-storage,NAMESPACE:.metadata.namespace'
kubectl get pods -o custom-columns='POD NAME:.metadata.name,SECURITY_CONTEXT:.spec.containers[0].securityContext.privileged,AS_GROUP:.spec.containers[0].securityContext.runAsGroup,AS_USER:.spec.containers[0].securityContext.runAsUser,NON_ROOT:.spec.containers[0].securityContext.runAsNonRoot,SERVICE_ACCOUNT:.spec.serviceAccount,NAMESPACE:.metadata.namespace'
kubectl get pods -o custom-columns='POD NAME:.metadata.name,VOLUME_MOUNT_PATH:.spec.containers[0].volumeMounts.*.mountPath,VOLUME_NAME:.spec.containers[0].volumeMounts.*.name,NAMESPACE:.metadata.namespace'

## Get custom columns/values of Ingress
# Get all path rules
kubectl get ingress -o custom-columns="NAME:.metadata.name,PATHS:.spec.rules[].http.paths[*].path"

# Get all pods running in a Node
kubectl get pods -o wide --all-namespaces --field-selector spec.nodeName=node-1

# Wait until reaching a specific state
kubectl wait --timeout=5m -n envoy-gateway-system deployment/envoy-gateway --for=condition=Available

## Force apply app using new ConfigMap
kubectl rollout restart deployment <DEPLOYMENT_NAME>
kubectl rollout status deployment <DEPLOYMENT_NAME> --watch=true
kubectl rollout restart statefulsets <DEPLOYMENT_NAME>
kubectl rollout status statefulsets <DEPLOYMENT_NAME> --watch=true

# Get app for Helm
kubectl get all --all-namespaces -l='app.kubernetes.io/managed-by=Helm'
kubectl get all --all-namespaces -l='app.kubernetes.io/managed-by=Helm,app.kubernetes.io/instance=kube-prometheus-stack'

# Kubectl copy file/folder from local to pod & vice versa
kubectl cp <FILE> <CONTAINER>:/<PATH>
kubectl cp <CONTAINER>:/<PATH> <FILE> 