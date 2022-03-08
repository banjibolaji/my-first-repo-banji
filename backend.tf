terraform {
  backend "s3" {
    bucket = "banji-terraform-statefiles"
    key = "jjtech-tf.tfstate"
    region = "us-east-2"
    profile = "default"
    dynamodb_table = "banji-jjtech-tfstate"
  }
}