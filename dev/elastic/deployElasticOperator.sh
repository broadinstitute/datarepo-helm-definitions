#! /#!/usr/bin/env bash
kubectl apply -f elasticOperatorPsp.yaml
kubectl apply -f https://download.elastic.co/downloads/eck/1.0.0/all-in-one.yaml
#kubectl -n elastic-system logs -f statefulset.apps/elastic-operator
