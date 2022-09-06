# Create Ecs Cluster
# terraform aws create ecs cluster
resource "aws_ecs_cluster" "ecs-cluster" {
  name = "devop-api"

  setting {
    name  = "containerInsights"
    value = "enabled"
  }
}


#create log group for ecs
resource "aws_cloudwatch_log_group" "logs" {
  name = "devop-api-logs"
}


#Create the task definition
# terraform aws create ecs task definition
resource "aws_ecs_task_definition" "Task" {
  family                   = "devop-api-task"
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = 256
  memory                   = 512

  execution_role_arn = aws_iam_role.ecs_role.arn
  depends_on         = [aws_ecr_repository.ecr-repo]
  container_definitions = jsonencode([
    {
      name      = "devop-api-container"
      image     = "xxxxxxxxxxxx.dkr.ecr.us-east-1.amazonaws.com/devop-api"
      cpu       = 256
      memory    = 512
      essential = true
      portMappings = [
        {
          containerPort = 2500
          hostPort      = 2500
        }
      ],

      log_configuration = [
        {
          logDriver : "awslogs",
          options : {
            awslogs-group : aws_cloudwatch_log_group.logs.name,
            awslogs-region : "us-east-1",
            awslogs-stream-prefix : "ecs"
          }
        }
      ]
    }
  ])
}

#Create the service
# terraform aws create ecs service
resource "aws_ecs_service" "service" {
  name            = "devop-api-service"
  depends_on      = [aws_lb_listener.test_listener, aws_lb_target_group.test-tg]
  cluster         = aws_ecs_cluster.ecs-cluster.id
  task_definition = aws_ecs_task_definition.Task.arn
  desired_count   = 1
  launch_type     = "FARGATE"

  network_configuration {
    subnets          = [aws_subnet.private-subnet-1.id, aws_subnet.private-subnet-2.id]
    security_groups  = [aws_security_group.container_sg.id]
    assign_public_ip = true
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.test-tg.id
    container_name   = "devop-api-container"
    container_port   = 2500
  }
}
