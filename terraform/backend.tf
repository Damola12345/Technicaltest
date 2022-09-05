terraform {
  backend "s3" {
    bucket  = "devop-test-remote-state-tf"
    key     = "technicaltest.tfstate"
    region  = "us-east-1"
    profile = "terraform-user"
  }
}
