module "ecr" {
  source = "./modules/ecr"

  namespace = "endv"
  for_each  = toset(["ml-eng"])
  name      = each.value

  policy = file("./iam/policies/ecr_policy.json")
}
