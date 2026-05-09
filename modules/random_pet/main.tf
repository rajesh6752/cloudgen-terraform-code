resource "random_pet" "this" {
  prefix = var.prefix
  length = var.length

  # Utilizing the keepers map to ensure all variables are strictly used
  # and to trigger recreation if global context changes.
  keepers = {
    organization = var.organization
    environment  = var.environment
    tags_hash    = md5(jsonencode(var.default_tags))
  }
}
