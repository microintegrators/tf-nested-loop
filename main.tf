###### main ########
locals {
   disks = flatten([
    for vm in var.vms: [
        for disk in vm.data_disks: {
           name        = disk[0]
           size        = disk[1]
           type        = disk[2]
           ami                = vm.ami
           instance_type      = vm.instance_type
           availability_zone  = vm.availability_zone
           vm_name            = vm.name 
        }
    ]
   ])
}


resource "aws_instance" "testvm" {
    for_each = var.vms
  ami               = each.value.ami
  availability_zone = each.value.availability_zone
  instance_type     = each.value.instance_type
}


resource "aws_ebs_volume" "ebs_create" {
    for_each = { for disk in local.disks: "${disk.vm_name}-${disk.name}" => disk}
  availability_zone = each.value.availability_zone
  size              = each.value.size
}




resource "aws_volume_attachment" "ebs_att" {
    for_each = { for disk in local.disks: "${disk.vm_name}-${disk.name}" => disk}
  device_name = each.value.name
  volume_id   = aws_ebs_volume.ebs_create["${each.value.vm_name}-${each.value.name}"].id
  instance_id = aws_instance.testvm[each.value.vm_name].id
}


