resource "aws_ecr_repository" "flask_repo" {
  name = "flask-backend-repo"
}

resource "aws_ecr_repository" "express_repo" {
  name = "express-frontend-repo"
}
