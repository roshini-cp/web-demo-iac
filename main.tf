terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }

  required_version = ">= 1.2.0"
}

provider "aws" {
  region = "ap-south-1"
}

resource "aws_instance" "test-server" {
  ami           = "ami-03f4878755434977f"
  instance_type = "t2.micro"
  tags = {
    Name = "test-server"
  }
}

resource "aws_ebs_volume" "test-vol" {
  availability_zone = "ap-south-1a"
  size              = 8
  tags = {
    Name = "test-vol"
  }
}

resource "aws_security_group" "test-sg" {
  name                   = "launch-wizard-3"
  description            = "launch-wizard-3 created 2024-02-21T07:42:24.694Z"
  revoke_rules_on_delete = null
  egress = [
    {
      cidr_blocks = [
        "0.0.0.0/0",
      ]
      description      = ""
      from_port        = 0
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      protocol         = "-1"
      security_groups  = []
      self             = false
      to_port          = 0
    },
  ]
  ingress = [
    {
      cidr_blocks = [
        "0.0.0.0/0",
      ]
      description      = ""
      from_port        = 22
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      protocol         = "tcp"
      security_groups  = []
      self             = false
      to_port          = 22
    },
    {
      cidr_blocks = [
        "0.0.0.0/0",
      ]
      description      = ""
      from_port        = 443
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      protocol         = "tcp"
      security_groups  = []
      self             = false
      to_port          = 443
    },
    {
      cidr_blocks = [
        "0.0.0.0/0",
      ]
      description      = ""
      from_port        = 8080
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      protocol         = "tcp"
      security_groups  = []
      self             = false
      to_port          = 8080
    },
    {
      cidr_blocks = [
        "0.0.0.0/0",
      ]
      description      = ""
      from_port        = 80
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      protocol         = "tcp"
      security_groups  = []
      self             = false
      to_port          = 80
    },
    {
      cidr_blocks = [
        "0.0.0.0/0",
      ]
      description      = ""
      from_port        = 8888
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      protocol         = "tcp"
      security_groups  = []
      self             = false
      to_port          = 8888
    },
  ]
  tags = {
    "Name" = "test-sg"
  }
  tags_all = {
    "Name" = "test-sg"
  }
  vpc_id = "vpc-079f7899d247f89fe"
}

resource "aws_lb" "test-lb" {
  name                             = "testl-lb"
  enable_cross_zone_load_balancing = true
  load_balancer_type               = "application"
  security_groups = [
    "sg-0352be7e90541a0de",
    "sg-0f80376c920db31b9",
  ]
  subnets = [
    "subnet-074205762939c374e",
    "subnet-09dd900ec9aaf07ab",
    "subnet-0e403a64c953d74a3",
  ]
  access_logs {
    enabled = false
    bucket  = ""
  }

  subnet_mapping {
    subnet_id = "subnet-074205762939c374e"
  }
  subnet_mapping {
    subnet_id = "subnet-09dd900ec9aaf07ab"
  }
  subnet_mapping {
    subnet_id = "subnet-0e403a64c953d74a3"
  }
}

resource "aws_lb_target_group" "test-tg1" {
  name     = "test-tg1"
  port     = 8088
  protocol = "HTTP"
  vpc_id   = "vpc-079f7899d247f89fe"
  health_check {
    enabled             = true
    healthy_threshold   = 5
    interval            = 30
    matcher             = "200"
    path                = "/"
    port                = "traffic-port"
    protocol            = "HTTP"
    timeout             = 5
    unhealthy_threshold = 2
  }
  stickiness {
    cookie_duration = 86400
    enabled         = false
    type            = "lb_cookie"
  }
}

resource "aws_lb_target_group" "tg" {
  name        = "tg"
  port        = 80
  protocol    = "HTTP"
  target_type = "ip"
  vpc_id      = "vpc-079f7899d247f89fe"
  health_check {
    enabled             = true
    healthy_threshold   = 5
    interval            = 30
    matcher             = "200"
    path                = "/"
    port                = "traffic-port"
    protocol            = "HTTP"
    timeout             = 5
    unhealthy_threshold = 2
  }

  stickiness {
    cookie_duration = 86400
    enabled         = false
    type            = "lb_cookie"
  }
}

resource "aws_subnet" "sn1" {
  vpc_id                     = "vpc-079f7899d247f89fe"
  cidr_block                 = "172.31.32.0/20"
  enable_lni_at_device_index = null
  map_public_ip_on_launch    = true
  tags = {
    "Name" = "sn1"
  }
  tags_all = {
    "Name" = "sn1"
  }
}

resource "aws_subnet" "sn2" {
  vpc_id                     = "vpc-079f7899d247f89fe"
  cidr_block                 = "172.31.0.0/20"
  enable_lni_at_device_index = null
  map_public_ip_on_launch    = true
  tags = {
    "Name" = "sn2"
  }
  tags_all = {
    "Name" = "sn2"
  }
}
resource "aws_subnet" "sn3" {
  vpc_id                     = "vpc-079f7899d247f89fe"
  cidr_block                 = "172.31.16.0/20"
  enable_lni_at_device_index = null
  map_public_ip_on_launch    = true
  tags = {
    "Name" = "sn3"
  }
  tags_all = {
    "Name" = "sn3"
  }
}

resource "aws_default_network_acl" "test-nacl" {
  default_network_acl_id = "acl-0e13b42f3a574f27b"
  ingress {
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    icmp_code  = 0
    icmp_type  = 0
    protocol   = "-1"
    rule_no    = 100
    to_port    = 0
  }

  egress {
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    icmp_code  = 0
    icmp_type  = 0
    protocol   = "-1"
    rule_no    = 100
    to_port    = 0
  }

  subnet_ids = [
    "subnet-074205762939c374e",
    "subnet-09dd900ec9aaf07ab",
    "subnet-0e403a64c953d74a3",
  ]
  tags = {
    "Name" = "test-nacl"
    "name" = "nacl-test"
  }
  tags_all = {
    "Name" = "test-nacl"
    "name" = "nacl-test"
  }
}

resource "aws_route_table" "test-route" {
  vpc_id = "vpc-079f7899d247f89fe"
  tags = {
    "Name" = "test-route"
  }
  tags_all = {
    "Name" = "test-route"
  }
}
resource "aws_vpc" "test-vpc" {
  tags = {
    "Name" = "test-vpc"
  }
  tags_all = {
    "Name" = "test-vpc"
  }
}
resource "aws_ecs_cluster" "test-ecs" {
  name = "test-ecs"

  configuration {
    execute_command_configuration {
      logging = "DEFAULT"
    }
  }

  service_connect_defaults {
    namespace = "arn:aws:servicediscovery:ap-south-1:218195379200:namespace/ns-e7p7lx3hpbgjlqms"
  }
}

resource "aws_ecs_service" "svc-test" {
  name                    = "svc-test"
  enable_ecs_managed_tags = true
  desired_count           = 1
  network_configuration {
    assign_public_ip = true
    security_groups = [
      "sg-0352be7e90541a0de",
      "sg-0f80376c920db31b9",
    ]
    subnets = [
      "subnet-074205762939c374e",
      "subnet-09dd900ec9aaf07ab",
      "subnet-0e403a64c953d74a3",
    ]
  }
  deployment_circuit_breaker {
    enable   = true
    rollback = true
  }

  deployment_controller {
    type = "ECS"
  }

  load_balancer {
    container_name   = "test-container"
    container_port   = 8080
    target_group_arn = "arn:aws:elasticloadbalancing:ap-south-1:218195379200:targetgroup/tg/ba4f481a98bd6fce"
  }
  propagate_tags  = "NONE"
  tags            = {}
  tags_all        = {}
  task_definition = "test-task:5"
  triggers        = {}


  capacity_provider_strategy {
    base              = 0
    capacity_provider = "FARGATE"
    weight            = 1
  }
}

resource "aws_ecs_task_definition" "test-task" {
  family = "test-task"
  cpu    = 1024
  memory = 3072
  requires_compatibilities = [
    "FARGATE",
  ]
  container_definitions = jsonencode([
    {
      environment        = []
      environmentFiles   = []
      image              = "218195379200.dkr.ecr.ap-south-1.amazonaws.com/my-repo:latest"
      cpu                = 0
      execution_role_arn = "arn:aws:iam::218195379200:role/ecsTaskExecutionRole"
      network_mode       = "awsvpc"
      requires_compatibilities = [
        "FARGATE",
      ]
      revision      = 5
      tags          = {}
      task_role_arn = "arn:aws:iam::218195379200:role/ecsTaskExecutionRole"
      essential     = true
      logConfiguration = {
        logDriver = "awslogs"
        options = {
          awslogs-create-group  = "true"
          awslogs-group         = "/ecs/test-task"
          awslogs-region        = "ap-south-1"
          awslogs-stream-prefix = "ecs"
        }
        secretOptions = []
      }
      mountPoints = []
      name        = "test-container"
      portMappings = [
        {
          appProtocol   = "http"
          name          = "8888"
          protocol      = "tcp"
          containerPort = 8080
          hostPort      = 8080
        },
        {
          containerPort = 8088
          hostPort      = 8088
          name          = "8080"
          protocol      = "tcp"
        },
      ]
      ulimits     = []
      volumesFrom = []
    },
  ])
  runtime_platform {
    cpu_architecture        = "X86_64"
    operating_system_family = "LINUX"
  }
  tags               = {}
  execution_role_arn = "arn:aws:iam::218195379200:role/ecsTaskExecutionRole"
  task_role_arn      = "arn:aws:iam::218195379200:role/ecsTaskExecutionRole"
}
