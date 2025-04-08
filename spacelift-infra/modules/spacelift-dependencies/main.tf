resource "spacelift_stack_dependency" "this" {
  for_each = var.dependencies

  stack_id            = each.value.child_stack_id != null ? each.value.child_stack_id : null
  depends_on_stack_id = each.value.parent_stack_id != null ? each.value.parent_stack_id : null
}

resource "spacelift_stack_dependency_reference" "this" {
  for_each = local.references

  stack_dependency_id = spacelift_stack_dependency.this[each.value.stack_dependency_id].id
  input_name          = each.value.input_name
  output_name         = each.value.output_name
  trigger_always      = each.value.trigger_always

  depends_on = [
    spacelift_stack_dependency.this
  ]
}
