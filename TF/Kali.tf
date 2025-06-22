resource "aws_instance" "kali" {
  ami           = "ami-0c55b159cbfafe1f0" #Kali linux AMI
  instance_type = "t2.micro"
  subnet_id     = "aws_subnet.main_subnet.id" 
  key_name      = "kali-kp-for-instanc"        
  tags = {
    Name = "KaliLinuxInstance"
  }
}

resource "aws_instance" "dvwa" {
  ami           = "ami-020cba7c55df1f615" #DVWA AMI (Ubuntu Server)
  instance_type = "t2.micro"
  subnet_id     = "aws_subnet.main_subnet.id" 
  key_name      = "dvwa-kp-for-instance"        
  tags = {
    Name = "DVWAInstance"
  }

}