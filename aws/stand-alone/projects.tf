module "sample_project" {
  source              = "./instance"
  project_name        = "sample_project"
  instance_type       = "t3a.medium"
  # region              = "us-west-1" # in case if we need to use non-defau
}