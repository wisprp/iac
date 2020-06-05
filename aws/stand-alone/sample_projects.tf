variable "dns_zone" {
    type = string
}
variable "dns_zone_id" {
    type = string
}
variable "public_key" {
    type = string
}

module "sample_project" {
  source              = "./instance"
  project_name        = "sample_project"
  instance_type       = "t3a.medium"
  # region              = "us-west-1" # in case if we need to use non-defau
  dns_zone            = var.dns_zone
  dns_zone_id         = var.dns_zone_id
  public_key          = var.public_key
  ebs_root_vol_size   = 8
}
