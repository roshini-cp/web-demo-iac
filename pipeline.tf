resource "aws_ecr_repository" "my-repo" {
  name = "my-repo"
}

resource "aws_codebuild_project" "web-demo" {
  name           = "web-demo"
  source_version = "main"
  artifacts {
    type = "NO_ARTIFACTS"
  }
  source {
    type            = "GITHUB"
    git_clone_depth = 1
    location        = "https://github.com/roshini-cp/webapp-demo.git"
    buildspec       = data.local_file.buildspec_local.content
    git_submodules_config {
      fetch_submodules = false
    }
  }
  environment {
    type                        = "LINUX_CONTAINER"
    image_pull_credentials_type = "CODEBUILD"
    privileged_mode             = true
    image                       = "aws/codebuild/amazonlinux2-x86_64-standard:5.0"
    compute_type                = "BUILD_GENERAL1_SMALL"
  }
  service_role = "arn:aws:iam::218195379200:role/service-role/codebuild-web-demo-service-role"
}

data "local_file" "buildspec_local" {
  filename = "${path.module}/buildspec.yml"
}
