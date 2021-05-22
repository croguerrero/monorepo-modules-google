#!/bin/bash

function get_project_id_by_prefix() {
    PROJECT_ID_PREFIX=$1
    PROJECTS=$2
    echo "${PROJECTS}" \
      | jq -rc  --arg project_id_prefix "${PROJECT_ID_PREFIX}" \
      '.[] | select(.projectId | startswith($project_id_prefix)) | .projectId'
}

PROJECTS=$(gcloud projects list --format=json | jq)
IAM_PROJECT=$(get_project_id_by_prefix "iam" "${PROJECTS}")
SECRET_PROJECT=$(get_project_id_by_prefix "secret" "${PROJECTS}")
NETWORK_PROJECT=$(get_project_id_by_prefix "network" "${PROJECTS}")
DATA_PROJECT=$(get_project_id_by_prefix "data" "${PROJECTS}")
COMPUTE_PROJECT=$(get_project_id_by_prefix "compute" "${PROJECTS}")
KUBEFLOW_PROJECT=$(get_project_id_by_prefix "kubeflow" "${PROJECTS}")
CLUSTER_NAME=$(gcloud container clusters list --project="${COMPUTE_PROJECT}" --format=json | jq -rc '.[0].name')

cat <<EOF > "${GITHUB_USER_WORKSPACE}/.envrc-projects"
export IAM_PROJECT=${IAM_PROJECT}
export SECRET_PROJECT=${SECRET_PROJECT}
export NETWORK_PROJECT=${NETWORK_PROJECT}
export DATA_PROJECT=${DATA_PROJECT}
export COMPUTE_PROJECT=${COMPUTE_PROJECT}
export KUBEFLOW_PROJECT=${COMPUTE_PROJECT}
export CLUSTER_NAME=${CLUSTER_NAME}
EOF

gcloud container clusters get-credentials --project="${COMPUTE_PROJECT}" --zone=us-central1-a "${CLUSTER_NAME}"
