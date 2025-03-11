# steps that executed

1. terraform setup a

launch an instance with t2.micro, keypair, securtity groups(all traffic) 
install terraform init
    sudo yum install -y yum-utils
    sudo yum-config-manager --add-repo https://rpm.releases.hashicorp.com/AmazonLinux/hashicorp.repo
    sudo yum -y install terraform
    terraform --version --> to check version 

write the terraform manifest files to launch instance( refer to provider.tf, main.tf, security.tf)

**provider.tf**

provider "aws"{
region = "us-east-1"
}

**main.t**f

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

**security.tf**

resource "aws_security_group" "mysg" {
name = "terraform-sg"
description= "it is created by terraform"

ingress{
from_port = 22
to_port = 22
protocol = "tcp"
cidr_blocks = ["0.0.0.0/0"]
}

ingress{
from_port = 80
to_port = 80
protocol = "tcp"
cidr_blocks = ["0.0.0.0/0"]
}
}

terraform init --> to initialize
terraform plan --> to check the changes with execution
terraform apply --auto-approve --> to excute 

The instance launched with t2.micro, default vpc, and with volume size 10GB and with security groups HTTP (port 80) and SSH (port 22).

## Web Server Setup:

yum install httpd -y 
systemctl start httpd 

vim index.html
<h1> hellow world </h1>

mv index.html /var/www/html

access with public ipaddress:80 -- 34.204.0.146:80

## 	System Automation

install ansible --> yum install python-pip -y 
                    amazon-linux-extras install ansible2 -y

Manifest file for automating the webserver installation and setup:
vim ansible.yml
---

- hosts: localhost
  connection: ssh
  tasks:
    - name: install web server
      yum: name=httpd state=present

    - name: start httpd
      service: name=httpd state=started

    - name: create a file
      file: path="/var/www/html/index.html" state=touch

    - name: add content
      copy:
        dest: "/var/www/html/index.html"
        content: |
          <h1> hello world..! <h1>
...

ansible-playbook ansible.yml --> to execute the playbook 

## Monitoring and Logging 

cloud watch is used for monitoring, store the log files of application, can setup alaram and can create dasboard for monitoring 

Created alaram in cloud watch to monitor our application by following below steps.

Cloud watch --> create alarm --> select our ec2 instances --> period 1minute and 60%(as the cpu utilization reaches above 60% more than one minute alaram will popout)
to get a email, create a topic and enable the subscription 

## CI/CD Workflow 

Installed jenkins as below 

          

