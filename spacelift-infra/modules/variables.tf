variable "dependencies" {
  description = "Map of dependencies with child and parent stack IDs"
  type = map(object({
    parent_stack_id = string
    child_stack_id  = string
    references      = optional(map(object({
      input_name      = string
      output_name     = string
      trigger_always  = bool
    })))
  }))
}

locals {
  references = merge([
    for dep_key, dep in var.dependencies : {
      for ref_key, ref in try(dep.references, {}) : "${dep_key}-${ref_key}" => {
        stack_dependency_id = dep_key
        input_name          = ref.input_name
        output_name         = ref.output_name
        trigger_always      = ref.trigger_always
      }
    }
  ]...)
}
