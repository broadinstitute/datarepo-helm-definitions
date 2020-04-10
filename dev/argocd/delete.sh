#!/bin/bash
helm delete argocd-application-controller --namespace argocd
helm delete argocd-server --namespace argocd
helm delete argocd-dex-server --namespace argocd
helm delete argocd-repo-server --namespace argocd
helm delete redis-sa-haproxy --namespace argocd
helm delete jade --namespace argocd
