# SUSE Virtualization Terraform Template
Terraform Template to provision VMs on SUSE Virtualization

This terraform template provision 2 resources, a count of sles and another count of ubuntu VMs.
Changing the image-name, cloud-config and ssh_keys value is necessary.

The KubeConfig file path also most be provided.
```
git clone https://github.com/abonillabeeche/svirt-terraform-vms.git
cd svirt-terraform-vms
```

Modify main.tf and change:

```
provider "harvester" {
  kubeconfig =
```

with the path to the kubeconfig file of your SUSE Virtualization Cluster
Download it via Rancher -> Virt Management -> Choose your Cluster -> Support -> Download KubeConfig

Ensure an ssh key is uploaded, do this via Advanced -> SSH Keys

Modify 
```
data "harvester_ssh_key" "abonilla" {
  name      = "abonilla"
  namespace = "default"
}
```
also

```
  ssh_keys = [
    data.harvester_ssh_key.abonilla.id
  ]
```

Modify 

```
    image = "default/image-rvjcv" # Change this to match your Harvester image
```
to match the image-name of your SLES and Ubuntu resource definition.

Modify the cloud-config section to match your username and content of your ssh public key, locate in both resources after:

```
  cloudinit {
    user_data = <<-EOF
      #cloud-config
```

Save the File

Continue with the deployment running

```
terraform init
terraform plan
terraform apply
```
Once the VMs are no longer needed

`terraform destroy`
