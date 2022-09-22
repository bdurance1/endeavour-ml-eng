module "kms" {
  source = "./modules/kms"

  env_name  = null
  namespace = "endv"
  name      = "service"

  description = null
  policy      = file("./iam/policies/kms_policy.json")

}
