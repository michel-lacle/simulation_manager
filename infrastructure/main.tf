module "simulation_cluster" {
  source = "./cluster"

  # cluster parameters
  name = var.application_name
  instance_type = "t2.micro" # 1 vCpu
  ami_id = "ami-0ac80df6eff0e70b5"
  size = 1

  # networking
  subnet_id = "subnet-02c253f85df6a198a" # public 1
  vpc_id = "vpc-07eeb01dd681ebeb5" # atodev
  key_pair_name = "simulation_cluster"

  contact_tag = var.contact_tag
  application_tag = var.application_tag
  managedby_tag = var.managed_by
  environment_tag = "dev"
}

module "cicd" {
  source = "./cicd"

  deploy_application_name = var.application_name
  branch = "master"
  deploy_environment_name = "dev"
  repository_name = "simulation_manager"

  contact_tag = var.contact_tag
  application_tag = var.application_tag
  managedby_tag = var.managed_by
}