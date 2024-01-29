if $(kubectl get namespace argocd >/dev/null 2>&1); then
  echo ArgoCD Namespace Exists
else
  kubectl create namespace argocd
fi

if $(kubectl get namespace monitoring >/dev/null 2>&1); then
  echo Monitoring Namespace Exists
else
  kubectl create namespace monitoring
fi

if helm status backend >/dev/null 2>&1; then
  helm upgrade backend ./backend
else
  helm install backend ./backend
fi
echo Backend Installed/Upgraded

if helm status frontend >/dev/null 2>&1; then
  helm upgrade frontend ./frontend
else
  helm install frontend ./frontend
fi
echo Frontend Installed/Upgraded

if helm status environment >/dev/null 2>&1; then
  helm upgrade environment ./environment
else
  helm install environment ./environment
fi
echo Environment Installed/Upgraded

if helm status argocd >/dev/null 2>&1; then
  helm upgrade argocd ./argocd -n argocd
else
  helm install argocd ./argocd -n argocd
fi
echo ArgoCD Installed/Upgraded

# if helm status monitoring >/dev/null 2>&1; then
#   helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
#   helm upgrade monitoring ./monitoring -n monitoring
# else
#  helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
#  helm install monitoring prometheus-community/prometheus -n monitoring
#  helm install monitoring ./monitoring -n monitoring
# fi
# echo Monitoring Installed/Upgraded

  

# kubectl apply -f ../argosetup.yml

# echo ArgoCD configured

