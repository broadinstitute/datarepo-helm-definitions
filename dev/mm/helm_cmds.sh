## These are my notes about how to run Helm. Originally was keeping them on my local machine, but this seems like a safer, more convenient place to put them.

## Connect to the non-split Broad VPN.
## Connect to the gke_broad-jade-dev_us-central1_dev-master Kubernetes cluster.

## Refresh cluster credentials.
gcloud container clusters get-credentials dev-master --region us-central1 --project broad-jade-dev

## Update the helm charts and install.
helm repo update
helm namespace upgrade mm-jade datarepo-helm/datarepo --version=0.1.3 --install --namespace mm -f mmDeployment.yaml


