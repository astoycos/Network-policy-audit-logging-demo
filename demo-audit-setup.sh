#!/bin/bash

oc apply -f log-ns.yaml

oc create namespace test-ingress

oc label namespace test-ingress network.openshift.io/policy-group=ingress

oc apply -f client.yaml -n default

oc apply -f server.yaml -n logging

oc apply -f client2.yaml -n test-ingress

oc apply -f client3.yaml -n logging

oc apply -f ocp-demo-policies.yaml -n logging 
