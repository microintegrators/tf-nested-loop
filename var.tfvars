vms = {
    "testvm1" = {
        "name"  = "testvm1"
        "ami" = "ami-0912f71e06545ad88"
        "availability_zone" = "ap-south-1a"
        "instance_type"     = "t2.micro"
        "data_disks"             = [["/dev/sdf","2","standard"],["/dev/sdh","1","gp3"]]

    }

    "testvm2" = {
    "name"  = "testvm2"
    "ami" = "ami-0912f71e06545ad88"
    "availability_zone" = "ap-south-1b"
    "instance_type"     = "t2.small"
    "data_disks"             = [["/dev/sdh","3","Standard"]]

    }
}