terraform {
backend "s3" {
bucket = "terraform-state-april-class-gulnaz"
key = "jenkins/us-east-1/tools/london/jenkins.tfstate"
region = "us-east-1"
  }
}