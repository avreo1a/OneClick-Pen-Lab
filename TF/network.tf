resource "aws_security_group" "kali_sg" {
  name        = "kali_security_group"
  description = "Allowing SSH from your IP and outbound to targets"
  vpc_id      = "aws_vpc.main.id"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.your_ip]  # Lock to your IP
  }


    egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0./0"] #allow all outbound
    }
} 5