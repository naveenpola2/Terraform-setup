resource "aws_instance" "one"{
tags= {
Name= "webserver"
}
ami= "ami-04aa00acb1165b32a"
instance_type= "t2.micro"
key_name= "newkey"
vpc_security_group_ids= [aws_security_group.mysg.id]
availability_zone = "us-east-1b"
root_block_device {
volume_size=10
}
}
