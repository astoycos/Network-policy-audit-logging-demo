#!/bin/bash


serverip=$(oc get pod server -n logging -o jsonpath={.status.podIP})

echo "Pinging from client in default namespace"
oc exec -n default client -- ping -w 1 -c 1 $serverip
echo
echo "Pinging from client2 in fake-ingress namespace"
oc exec -n test-ingress client2 -- ping -w 1 -c 1 $serverip
echo
echo "Pinging from client3 in logging namespace"
oc exec -n logging client3 -- ping -w 1 -c 1 $serverip 



