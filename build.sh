#!/usr/bin/env sh

JOB_NAME=${JOB_NAME:-"k8stest"}
BUILD_NUMBER=${BUILD_NUMBER:-1}

REGISTRY_URL=${REGISTRY_URL:-"127.0.0.1:5000/liaotao/"}

#docker build
echo execute : docker build -t app-${JOB_NAME}:${BUILD_NUMBER} .
docker build -t app-${JOB_NAME}:${BUILD_NUMBER} .

#docker tag
echo execute : docker tag app-${JOB_NAME}:${BUILD_NUMBER} ${REGISTRY_URL}app-${JOB_NAME}:${BUILD_NUMBER}
docker tag app-${JOB_NAME}:${BUILD_NUMBER} ${REGISTRY_URL}app-${JOB_NAME}:${BUILD_NUMBER}

#docker push
echo execute : docker push ${REGISTRY_URL}app-${JOB_NAME}:${BUILD_NUMBER}
docker push ${REGISTRY_URL}app-${JOB_NAME}:${BUILD_NUMBER}

#Update existing container image(s) of resources
#/usr/local/bin/kubectl set image deployment/k8stest-deployment k8stest=liaotao/app-${JOB_NAME}:${BUILD_NUMBER} --namespace=default --kubeconfig=/Users/ethanliao/.kube/config
