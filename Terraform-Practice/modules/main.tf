terraform {
  backend "s3" {
    bucket = "nithinbucketterraform"
    key    = "practice/terraform.tfstate"
    region = "us-east-1"
  }
}

module "ec2" {
  source = "./ec2"
  SG_ID = module.sg.SG_ID
}

module "sg" {
  source = "./sg"
}
