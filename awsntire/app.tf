#Creating the network security group for the inbound and outbound network for the DB

resource "aws_security_group" "app-sg" {
  name        = "allow_app"
  description = "Allow tomcat inbound traffic"
  vpc_id      = aws_vpc.sunbird_VPC.id

  ingress {
      description = "creating the inbound rule for the app"
      cidr_blocks = ["0.0.0.0/0"]
      from_port =  8080
      protocol = "tcp"
      to_port = 8080
  }
  ingress {
      description = "accessing the instance via 22 port"
      cidr_blocks = ["0.0.0.0/0"]
      from_port =  22
      protocol = "tcp"
      to_port = 22
  }


  egress {
      description = "creating the outbound rule for the app"
      cidr_blocks = ["0.0.0.0/0"]
      from_port =  0
      protocol = "tcp"
      to_port = 65535
  }  
  depends_on    = [
      aws_db_instance.sunbird_primary_db
  ]
}

resource "aws_instance" "app-server" {
    ami           = "ami-0e82959d4ed12de3f"
    instance_type = "t2.micro"
    key_name   = "terraform"
    vpc_security_group_ids = aws_security_group.app-sg.id
    associate_public_ip_address = true
    subnet_id  = aws_subnet.sunbird_subnets[1].id
    tags    ={
        Name = "tomcat-app-server"
    }
    connection {
    type     = "ssh"
    user     = "ubuntu"
    host     = self.public_ip
    private_key = file("./terraform.pem")


    provisioner "remote-exec" {
    inline = [
            "sudo apt update",
            "sudo apt install tomcat8 tomcat8-admin tomcat8-common tomcat8-docs tomcat8-examples -y",
            "cd /var/lib/tomcat8/webapps",
            "sudo wget https://referenceappkhaja.s3-us-west-2.amazonaws.com/gameoflife.war"
    ]
  }
}

  }


