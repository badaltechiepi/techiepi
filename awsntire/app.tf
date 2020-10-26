#Creating the network security group for the inbound and outbound network for the DB

resource "aws_security_group" "app-sg" {
  name        = var.app_subnet_name
  description = "Allow tomcat inbound traffic"
  vpc_id      = aws_vpc.sunbird_VPC.id

  ingress {
      description = "creating the inbound rule for the app"
      cidr_blocks = [ local.cidr_block ]
      from_port =  local.ingress_from_app_port
      protocol = local.proto
      to_port = local.ingress_to_app_port
  }
  ingress {
      description = "accessing the instance via 22 port"
      cidr_blocks = [ local.cidr_block ]
      from_port =  local.ingress_ssh_port
      protocol = "tcp"
      to_port = local.ingress_ssh_port
  }


  egress {
      description = "creating the outbound rule for the app"
      cidr_blocks = [ local.cidr_block ]
      from_port =  local.egress_from_port
      protocol = "tcp"
      to_port = local.egress_to_port
  }  
  depends_on    = [
      aws_db_instance.sunbird_primary_db
  ]
}

/* resource "aws_instance" "app-server" {
    ami                         = var.ec2_ami
    instance_type               = var.instance_type
    key_name                    = var.key_name
    vpc_security_group_ids      = [aws_security_group.app-sg.id]
    associate_public_ip_address = true
    subnet_id                   = aws_subnet.sunbird_subnets[local.primary_app_subnet_id].id
    tags                        ={
    Name                        = var.instance_name
    }

    connection                  {
    type                        = "ssh"
    user                        = "ubuntu"
    host                        = self.public_ip
   private_key                  = file("./terraform.pem")
    }

    provisioner "remote-exec" {
    inline = [
            "sudo apt update",
            "sudo apt install tomcat8 tomcat8-admin tomcat8-common tomcat8-docs tomcat8-examples -y",
            "cd /var/lib/tomcat8/webapps",
            "sudo wget https://referenceappkhaja.s3-us-west-2.amazonaws.com/gameoflife.war"
    ]
  }
}
 */

 ## appserver

resource "aws_instance" "app-server" {
    # needs to be changed
    ami                         = var.ec2_ami
    instance_type               = var.instance_type
    key_name                    = var.key_name
    vpc_security_group_ids      = [ aws_security_group.app-sg.id ]
    associate_public_ip_address = true
    subnet_id                   = aws_subnet.sunbird_subnets[local.primary_app_subnet_id].id

    tags                        = {
        Name                    = var.instance_name
    }

    connection {
        type                    = "ssh"
        user                    = "ubuntu"
        host                    = self.public_ip
        private_key             = file("./terraform.pem")
    }

    provisioner "remote-exec" {
        inline                  = [
            "sudo apt update",
            "sudo apt install tomcat8 tomcat8-admin tomcat8-common tomcat8-docs tomcat8-examples -y",
            "cd /var/lib/tomcat8/webapps",
            "sudo wget https://referenceappkhaja.s3-us-west-2.amazonaws.com/gameoflife.war"
        ]

    }

}



