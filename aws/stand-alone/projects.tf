variable "dns_zone" {
    type = string
}
variable "dns_zone_id" {
    type = string
}

module "sample_project" {
  source              = "./instance"
  project_name        = "sample_project"
  instance_type       = "t3a.medium"
  # region              = "us-west-1" # in case if we need to use non-defau
  dns_zone            = var.dns_zone
  dns_zone_id         = var.dns_zone_id
}