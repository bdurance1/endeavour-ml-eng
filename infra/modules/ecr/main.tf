resource "aws_ecr_repository" "ecr_repo" {
  name                 = "${var.namespace}-${var.name}"
  image_tag_mutability = "MUTABLE"
}

resource "aws_ecr_repository_policy" "ecr_repo_policy" {
  repository = aws_ecr_repository.ecr_repo.name
  policy     = var.policy
}
