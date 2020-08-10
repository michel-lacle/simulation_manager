variable "deploy_application_name" {
  type = string
  description = "the name of the application this cicd is going to build"
}

variable "branch" {
  type = string
  description = "the source code branch to build"
}

variable "repository_name" {
  type = string
  description = "the name of the codecommit repository"
}

variable "deploy_environment_name" {
  type = string
  description = "environment to deploy to"
}

#
# the tags for this module
#
variable "application_tag" {
  type = string
}

variable "contact_tag" {
  type = string
}

variable "managedby_tag" {
  type = string
}