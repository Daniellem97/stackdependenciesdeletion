module "ec2_stack" {
  source = "./stacks/ec2_stack.tf"
}

module "rds_stack" {
  source = "./stacks/rds_stack.tf"
}

module "dependencies" {
  source = "./modules/spacelift-dependencies"

  dependencies = {
    ec2_to_rds = {
      parent_stack_id = module.ec2_stack.stack_id
      child_stack_id  = module.rds_stack.stack_id
      references = {
        hostname = {
          input_name     = "hostname"
          output_name    = "hostname"
          trigger_always = false
        }
      }
    }
  }

  depends_on = [
    module.ec2_stack,
    module.rds_stack
  ]
}
