resource "random_string" "rancher_cloud_cred_random" {
  count            = var.existing_vpc ? 1 : 0
  upper            = false
  length           = 8
  special          = false
  override_special = "/@\" "
}

# Provider config
provider "rancher2" {
  api_url    = var.rancher_api_url
  token_key  = var.TOKEN_KEY
}

resource "rancher2_cloud_credential" "test" {
  count = var.existing_vpc ? 1 : 0
  name  = "cc-${random_string.rancher_cloud_cred_random[count.index].result}"

  amazonec2_credential_config {
    access_key = var.AWS_ACCESS_KEY_ID
    secret_key = var.AWS_SECRET_ACCESS_KEY
  }
}
