output "kubeconfig" {
  value = linode_lke_cluster.message-board-cluster.kubeconfig
  sensitive = true
}