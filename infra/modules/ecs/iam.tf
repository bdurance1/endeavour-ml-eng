# IAM "task execution" role that the Amazon ECS container agent and the Docker daemon 
# can assume. Used to gather elements required to launch the container image.
resource "aws_iam_role" "ecs_execution_role" {
  name = "${var.namespace}-${var.environment}-${var.name}-ecs-execution-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "ecs-tasks.amazonaws.com"
        }
      },
    ]
  })

  tags = {
    Name        = "${var.namespace}-${var.environment}-${var.name}-ecs-execution-role"
    Environment = "${var.environment}"
    Origin      = "terraform"
  }
}

# Attach IAM "task execution" role to AWS built-in policy, grants common ECS execution 
# rights, like accessing ECRs and writing to CloudWatch.
resource "aws_iam_role_policy_attachment" "ecs_execution_role" {
  role       = aws_iam_role.ecs_execution_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

# IAM role that allows your Amazon ECS container task to make calls to other AWS services.
resource "aws_iam_role" "ecs_task_role" {
  name = "${var.namespace}-${var.environment}-${var.name}-ecs-task-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "ecs-tasks.amazonaws.com"
        }
      },
    ]
  })

  tags = {
    Name        = "${var.namespace}-${var.environment}-${var.name}-ecs-task-role"
    Environment = "${var.environment}"
    Origin      = "terraform"
  }
}
