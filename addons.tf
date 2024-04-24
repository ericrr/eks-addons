module "manager_lbcontroller" {
  source          = "./modules/lbcontroller"
  count = var.lbcontroller.enabled ? 1 : 0

  cluster_name    =  var.cluster_name
  lbcontroller    =  var.lbcontroller
  cluster_identity_oidc_issuer  = "${replace(data.aws_eks_cluster.cluster.identity[0].oidc[0].issuer, "https://", "")}:sub"
  cluster_identity_oidc_issuer_arn = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:oidc-provider/${replace(data.aws_eks_cluster.cluster.identity[0].oidc[0].issuer, "https://", "")}"

}

module "manager_nginx" {
  source          = "./modules/nginx"
  count           = var.nginx.enabled ? 1 : 0

  cluster_name    = var.cluster_name
  nginx           = var.nginx
  nginx_configs   = var.nginx_configs

}

