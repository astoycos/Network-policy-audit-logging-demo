#!/bin/bash

echo Default Namespace Pods:
oc get pods -n default -o wide
echo test-ingress Namespace Pods:
oc get pods -n test-ingress -o wide
echo logging Namespace Pods:
oc get pods -n logging -o wide 
echo 
echo "Namespace's definition with custom acl-logging annotations:"
cat log-ns.yaml
echo  
oc get netpol -A -o wide

SERVNODE=$(oc get pod server -n logging -o wide | grep server | awk -F' ' '{print $7}') 
echo
echo "Looking for audit logs on node: ${SERVNODE}"
NODEPOD=$(oc get pods -n openshift-ovn-kubernetes -o wide |  grep ovnkube-node | grep -w ${SERVNODE}  | awk -F' ' '{print $1}')

echo "oc logs -f ${NODEPOD} --since 10s -n openshift-ovn-kubernetes -c ovn-acl-logging"
oc logs -f ${NODEPOD} --since 10s -n openshift-ovn-kubernetes -c ovn-acl-logging
