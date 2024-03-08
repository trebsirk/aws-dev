cd terraform

tf_log=${1:ERROR}
# Set TF_LOG to DEBUG
export TF_LOG=$tf_log

# Run Terraform commands (e.g., plan, apply, etc.)
terraform plan
terraform apply

# Unset TF_LOG after you're done
unset TF_LOG

cd ..