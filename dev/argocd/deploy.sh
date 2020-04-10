#!/bin/bash
helm namespace upgrade argocd-application-controller datarepo-helm/serviceaccount-psp --install --namespace argocd --set serviceAccount.name=argocd-application-controller
helm namespace upgrade argocd-server datarepo-helm/serviceaccount-psp --install --namespace argocd --set serviceAccount.name=argocd-server
helm namespace upgrade argocd-dex-server datarepo-helm/serviceaccount-psp --install --namespace argocd --set serviceAccount.name=argocd-dex-server
helm namespace upgrade argocd-repo-server datarepo-helm/serviceaccount-psp --install --namespace argocd --set serviceAccount.name=argocd-repo-server
helm namespace upgrade redis-sa-haproxy datarepo-helm/serviceaccount-psp --install --namespace argocd --set serviceAccount.name=redis-sa-haproxy
helm namespace upgrade jade argo/argo-cd --install --namespace argocd -f argocd.yaml
