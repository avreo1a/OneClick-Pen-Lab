resource "aws_instance" "kali" {
  ami           = "ami-05765033efd970565" #Kali linux AMI
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.main_subnet.id
  key_name      = "TFKali"        
  tags = {
    Name = "KaliLinuxInstance"
  }
}

resource "aws_instance" "dvwa" {
  ami           = "ami-020cba7c55df1f615" #DVWA AMI (Ubuntu Server)
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.main_subnet.id
  key_name      = "TFKali"        
  tags = {
    Name = "DVWAInstance"
  }

}