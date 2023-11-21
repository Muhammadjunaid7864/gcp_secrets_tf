locals {
  project = "charming-hearth-404722"
}

resource "vault_gcp_secret_backend" "gcp" {
  path        = "gcp"
  credentials = "${file("credentials.json")}"
}

resource "vault_gcp_secret_roleset" "roleset" {
  backend      = vault_gcp_secret_backend.gcp.path
  service_account_email = "junaid.sharif104@gmail.com"
  roleset      = "project_viewer"
  secret_type  = "access_token"
  project      = local.project
  token_scopes = ["https://www.googleapis.com/auth/cloud-platform"]

  binding {
    resource = "//cloudresourcemanager.googleapis.com/projects/${local.project}"

    roles = [
      "roles/viewer",
    ]
  }
}

# resource "vault_auth_backend" "gcp" {
#   path = "gcp"
#   type = "gcp"
# }

# resource "vault_gcp_auth_backend_role" "test" {
#   backend                = vault_auth_backend.gcp.path
#   role                   = "test"
#   type                   = "iam"
#   bound_service_accounts = ["test"]
#   bound_projects         = ["test"]
#   token_ttl              = 300
#   token_max_ttl          = 600
#   token_policies         = ["default"]
#   add_group_aliases      = true
# }