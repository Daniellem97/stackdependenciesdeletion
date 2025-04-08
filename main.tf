resource "spacelift_stack_dependency" "dependency" {
  stack_id            = spacelift_stack.app.id
  depends_on_stack_id = spacelift_stack.infra.id

  depends_on = [
    spacelift_stack.app,
    spacelift_stack.infra
  ]
}

resource "spacelift_stack_dependency_reference" "reference" {
  stack_dependency_id = spacelift_stack_dependency.dependency.id
  output_name         = "DB_CONNECTION_STRING"
  input_name          = "TF_VAR_APP_DB_URL"

  depends_on = [
    spacelift_stack_dependency.dependency
  ]
}

resource "spacelift_stack" "infra" {
  branch       = "main"
  name         = "Infrastructure stack"
  repository   = "intermediate-repo"
  project_root = "Stack-Dependencies/Infra"
}

resource "spacelift_stack" "app" {
  branch       = "main"
  name         = "Application stack"
  repository   = "intermediate-repo"
  project_root = "Stack-Dependencies/App"
}
