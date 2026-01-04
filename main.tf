provider "aws" {
  region = "us-east-1"
}

resource "aws_lightsail_instance" "amazon_linux_server" {
  name              = "server"
  availability_zone = "us-east-1a"

  # The blueprint ID for Amazon Linux 2023
  blueprint_id = "amazon_linux_2023"

  # Standard nano plan ($3.50/mo)
  bundle_id = "nano_3_0"

  # We are leaving 'key_pair_name' out so it uses the 
  # Default Key for us-east-1.

  tags = {
    OS = "AmazonLinux2023"
  }
}

# Opening Port 22 so you can actually connect
resource "aws_lightsail_instance_public_ports" "ssh_access" {
  instance_name = aws_lightsail_instance.amazon_linux_server.name

  port_info {
    protocol  = "tcp"
    from_port = 22
    to_port   = 22
  }
}

output "instance_ip" {
  value = aws_lightsail_instance.amazon_linux_server.public_ip_address
}