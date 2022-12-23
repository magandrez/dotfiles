#!/usr/bin/env bash
################################################################################
# Purpose:
#               Retrieve all the Kubernetes definitions on a cluster
#               for a given namespace and export them as YAML files under
#               folders separated by object type.
# Requirements:
#               - docker
#               - kubectl
#               - Access to a cluster (i.e.: valid ~/.kube/config after issuing
#                 '$ gcloud auth login')
# Author:       Manuel González
################################################################################

set -o errexit

log() {
    echo "$@" > /dev/stdout
}

err() {
    echo "$@" > /dev/stderr
}

die() {
    err "$@"
    exit 1
}

usage() {
    die "Usage: $0 <namespace> <output_folder>

where <namespace> is:
    dev        -- To retrieve manifests from dev namespace.
    test       -- To retrieve manifests from test namespace.
    production -- To retrieve manifests from production namespace.

and <output_foder> is the full path to a folder where to save the manifests.

Example: ./k8s_manifest_dump.sh dev $PWD/manifests"
}

if [ "$#" -ne 2 ]; then
    usage
fi

namespace="$1"
folder="$2"

log "Dumping all resources from namespace '$namespace'. " \
    "This will take some time."
for resource in $(kubectl api-resources \
                  --namespaced \
                  -o name \
                  --verbs=list \
                  -n "$namespace")
do
    log "Creating resource folder $folder/$resource"
    mkdir -p "$folder/$resource"
    for manifest in $(kubectl get "$resource" \
                      --ignore-not-found \
                      -o name \
                      --namespace "$namespace")
    do
        name=$(kubectl get "$manifest" -o yaml --namespace "$namespace" | \
                   docker run -i --rm mikefarah/yq '.metadata.name' -)
        log "Dumping $manifest/$name"
        kubectl get "$manifest" -o yaml -n "$namespace" \
                | docker run -i --rm mikefarah/yq \
        'del(.metadata.generation,
        .metadata.resourceVersion,
        .metadata.uid,
        .metadata.annotations,
        .metadata.creationTimestamp,
        .metadata.selfLink,
        .metadata.managedFields,
        .status,
        .spec.clusterIP,
        .spec.clusterIPs,
        .spec.externalTrafficPolicy,
        .spec.internalTrafficPolicy,
        .spec.ipFamilies,
        .spec.ipFamilyPolicy,
        .spec.ports.[0].nodePort,
        .spec.sessionAffinity,
        .secrets)' - > "$folder/$resource/$name.yaml"
    done
done
