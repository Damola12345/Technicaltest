#create aws ecr repository 
resource "aws_ecr_repository" "ecr-repo" {
  name                 = "devop-api"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = false
  }
}