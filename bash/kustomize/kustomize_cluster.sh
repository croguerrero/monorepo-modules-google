#!/bin/bash
CLUSTER=$1
PATHS=(
  "kustomize/manifests/kubeflow/1.3/overlays/${CLUSTER}/common/cert-manager/cert-manager/overlays/letsencrypt"
  "kustomize/manifests/kubeflow/1.3/overlays/${CLUSTER}/common/istio-1-9-0/istio-install/base"
  "kustomize/manifests/kubeflow/1.3/overlays/${CLUSTER}/common/oidc-authservice/base"
  "kustomize/manifests/kubeflow/1.3/overlays/${CLUSTER}/common/dex/overlays/istio"
  "kustomize/manifests/kubeflow/1.3/overlays/${CLUSTER}/common/knative/knative-serving-install/base"
  "kustomize/manifests/kubeflow/1.3/overlays/${CLUSTER}/common/istio-1-9-0/kubeflow-istio-resources/base"
  "kustomize/manifests/flux-kustomization/external-secrets/overlays/${CLUSTER}"
  "kustomize/manifests/flux-kustomization/external-dns/overlays/${CLUSTER}"
  "kustomize/manifests/flux-kustomization/secrets/kubeflow/overlays/${CLUSTER}"
  "kustomize/manifests/flux-kustomization/kubeflow/1.3/overlays/${CLUSTER}"
  "kustomize/manifests/flux-kustomization/cluster/overlays/${CLUSTER}"
  "kustomize/manifests/deploy/overlays/${CLUSTER}"
)

for path in "${PATHS[@]}"; do
  mkdir -p "${path}"
done

# cert-manager
cat <<EOF > "kustomize/manifests/kubeflow/1.3/overlays/${CLUSTER}/common/cert-manager/cert-manager/overlays/letsencrypt/patch-cluster-issuer.yaml"
kind: ClusterIssuer

EOF

cat <<EOF > "kustomize/manifests/kubeflow/1.3/overlays/${CLUSTER}/common/cert-manager/cert-manager/overlays/letsencrypt/kustomization.yaml"
resources:
- ../../../kubeflow/1.3/base/common/cert-manager/cert-manager/overlays/letsencrypt
patchesStrategicMerge:
- patch-cluster-issuer.yaml

EOF

# istio-install
cat <<EOF > "kustomize/manifests/kubeflow/1.3/overlays/${CLUSTER}/common/istio-1-9-0/istio-install/base/patch-service.yaml"
kind: Service

EOF

cat <<EOF > "kustomize/manifests/kubeflow/1.3/overlays/${CLUSTER}/common/istio-1-9-0/istio-install/base/kustomization.yaml"
resources:
- ../../../kubeflow/1.3/base/common/istio-1-9-0/istio-install/base
patchesStrategicMerge:
- patch-service.yaml

EOF

# oidc-authservice
cat <<EOF > "kustomize/manifests/kubeflow/1.3/overlays/${CLUSTER}/common/oidc-authservice/base/patch-config.yaml"
kind: ConfigMap

EOF

cat <<EOF > "kustomize/manifests/kubeflow/1.3/overlays/${CLUSTER}/common/oidc-authservice/base/kustomization.yaml"
resources:
- ../../../kubeflow/1.3/base/common/oidc-authservice/base
patchesStrategicMerge:
- patch-config.yaml

EOF

# dex
cat <<EOF > "kustomize/manifests/kubeflow/1.3/overlays/${CLUSTER}/common/dex/overlays/istio/patch-config.yaml"
kind: ConfigMap

EOF

cat <<EOF > "kustomize/manifests/kubeflow/1.3/overlays/${CLUSTER}/common/dex/overlays/istio/kustomization.yaml"
resources:
- ../../../kubeflow/1.3/base/common/dex/overlays/istio
patchesStrategicMerge:
- patch-config.yaml

EOF

# knative-serving-install
cat <<EOF > "kustomize/manifests/kubeflow/1.3/overlays/${CLUSTER}/common/knative/knative-serving-install/base/patch-config.yaml"
kind: ConfigMap

EOF

cat <<EOF > "kustomize/manifests/kubeflow/1.3/overlays/${CLUSTER}/common/knative/knative-serving-install/base/kustomization.yaml"
resources:
- ../../../kubeflow/1.3/common/knative/knative-serving-install/base
patchesStrategicMerge:
- patch-config.yaml

EOF

# kubeflow-istio-resources
cat <<EOF > "kustomize/manifests/kubeflow/1.3/overlays/${CLUSTER}/common/istio-1-9-0/kubeflow-istio-resources/base/patch-gateway.yaml"
kind: Gateway

EOF

cat <<EOF > "kustomize/manifests/kubeflow/1.3/overlays/${CLUSTER}/common/istio-1-9-0/kubeflow-istio-resources/base/kustomization.yaml"
resources:
- ../../../kubeflow/1.3/common/istio-1-9-0/kubeflow-istio-resources/base
patchesStrategicMerge:
- patch-gateway.yaml

EOF

# flux-kustomization
cat <<EOF > "kustomize/manifests/flux-kustomization/external-secrets/overlays/${CLUSTER}/patch-flux-kustomization.yaml"
apiVersion: kustomize.toolkit.fluxcd.io/v1beta1
kind: Kustomization
metadata:
  name: external-secrets
spec:
  path: kustomize/manifests/external-secrets/overlays/${CLUSTER}

EOF

cat <<EOF > "kustomize/manifests/flux-kustomization/external-secrets/overlays/${CLUSTER}/kustomization.yaml"
resources:
- ../../base
patchesStrategicMerge:
- patch-flux-kustomization.yaml

EOF

cat <<EOF > "kustomize/manifests/flux-kustomization/external-dns/overlays/${CLUSTER}/patch-flux-kustomization.yaml"
apiVersion: kustomize.toolkit.fluxcd.io/v1beta1
kind: Kustomization
metadata:
  name: external-dns
spec:
  path: kustomize/manifests/external-dns/overlays/${CLUSTER}

EOF

cat <<EOF > "kustomize/manifests/flux-kustomization/secrets/kubeflow/overlays/${CLUSTER}/kustomization.yaml"
resources:
- ../../base
patchesStrategicMerge:
- patch-flux-kustomization.yaml

EOF

cat <<EOF > "kustomize/manifests/flux-kustomization/secrets/kubeflow/overlays/${CLUSTER}/patch-flux-kustomization.yaml"
apiVersion: kustomize.toolkit.fluxcd.io/v1beta1
kind: Kustomization
metadata:
  name: kubeflow-secrets
spec:
  path: kustomize/manifests/secrets/kubeflow/overlays/${CLUSTER}

EOF

cat <<EOF > "kustomize/manifests/flux-kustomization/secrets/kubeflow/overlays/${CLUSTER}/kustomization.yaml"
resources:
- ../../base
patchesStrategicMerge:
- patch-flux-kustomization.yaml

EOF

cat <<EOF > "kustomize/manifests/flux-kustomization/kubeflow/1.3/overlays/${CLUSTER}/patch-flux-kustomization.yaml"
apiVersion: kustomize.toolkit.fluxcd.io/v1beta1
kind: Kustomization
metadata:
  name: cert-manager
spec:
  path: kustomize/manifests/kubeflow/1.3/overlays/${CLUSTER}/common/cert-manager/cert-manager/overlays/letsencrypt
---
apiVersion: kustomize.toolkit.fluxcd.io/v1beta1
kind: Kustomization
metadata:
  name: istio-install
spec:
  path: kustomize/manifests/kubeflow/1.3/overlays/${CLUSTER}/common/istio-1-9-0/istio-install/base
---
apiVersion: kustomize.toolkit.fluxcd.io/v1beta1
kind: Kustomization
metadata:
  name: oidc-authservice
spec:
  path: kustomize/manifests/kubeflow/1.3/overlays/${CLUSTER}/common/oidc-authservice/base
---
apiVersion: kustomize.toolkit.fluxcd.io/v1beta1
kind: Kustomization
metadata:
  name: dex
spec:
  path: kustomize/manifests/kubeflow/1.3/overlays/${CLUSTER}/common/dex/overlays/istio
---
apiVersion: kustomize.toolkit.fluxcd.io/v1beta1
kind: Kustomization
metadata:
  name: knative-serving-install
spec:
  path: kustomize/manifests/kubeflow/1.3/overlays/${CLUSTER}/common/knative/knative-serving-install/base
---
apiVersion: kustomize.toolkit.fluxcd.io/v1beta1
kind: Kustomization
metadata:
  name: kubeflow-istio-resources
spec:
  path: kustomize/manifests/kubeflow/1.3/overlays/${CLUSTER}/common/istio-1-9-0/kubeflow-istio-resources/base

EOF

cat <<EOF > "kustomize/manifests/flux-kustomization/kubeflow/1.3/overlays/${CLUSTER}/kustomization.yaml"
resources:
- ../../base
patchesStrategicMerge:
- patch-flux-kustomization.yaml

EOF

cat <<EOF > "kustomize/manifests/flux-kustomization/cluster/overlays/${CLUSTER}/patch-flux-kustomization.yaml"
apiVersion: kustomize.toolkit.fluxcd.io/v1beta1
kind: Kustomization
metadata:
  name: cluster
spec:
  path: kustomize/manifests/flux-kustomization/cluster/overlays/${CLUSTER}

EOF

cat <<EOF > "kustomize/manifests/deploy/overlays/${CLUSTER}/kustomization.yaml"
namespace: flux-system
resources:
- ../../base
- ../../../flux-kustomization/cluster/overlays/${CLUSTER}

EOF
