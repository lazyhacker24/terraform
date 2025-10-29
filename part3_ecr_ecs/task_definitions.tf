resource "aws_ecs_task_definition" "flask_task" {
  family                   = "flask-task"
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = "256"
  memory                   = "512"

  container_definitions = jsonencode([
    {
      name      = "flask"
      image     = "${aws_ecr_repository.flask_repo.repository_url}:latest"
      portMappings = [{ containerPort = 5000 }]
    }
  ])

  execution_role_arn = aws_iam_role.ecs_task_exec.arn
}

resource "aws_ecs_task_definition" "express_task" {
  family                   = "express-task"
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = "256"
  memory                   = "512"

  container_definitions = jsonencode([
    {
      name      = "express"
      image     = "${aws_ecr_repository.express_repo.repository_url}:latest"
      portMappings = [{ containerPort = 3000 }]
    }
  ])

  execution_role_arn = aws_iam_role.ecs_task_exec.arn
}
