# Terraform module to create a VM with a public IP on Outscale

## Usage

### Configure Outscale account

```shell
export OUTSCALE_ACCESSKEYID="<Outscale_AK>"
export OUTSCALE_SECRETKEYID="<Outscale_SK>"
export OUTSCALE_REGION="eu-west-2"
```

### Configure Terraform

Create a `terraform.tfvars` file with the filename of the SSH public key to use:

```shell
cat <<EOF > terraform.tfvars
public_key_file = "~/.ssh/id_ed25519.pub"
EOF
```

Initialize Terraform:

```shell
terraform init
```

### Create the Outscale resources

Review and apply the Terraform plan:

```shell
terraform apply
```

This will create a **VPC** with a **public subnet** (including an **Internet Gateway** with a **default route** pointing to it) and a **VM** with a **public IP**.

### Connect to the VM

When everything is created, refresh the output values (to get the public IP):

```shell
terraform refresh
```

And connect to the VM via SSH:

```shell
ssh outscale@$(terraform output -raw vm_public_ip)
```

> Add the SSH key to your SSH agent before connecting