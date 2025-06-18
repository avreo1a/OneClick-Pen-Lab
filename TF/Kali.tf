resource "aws_instance" "kali" {
  ami           = "ami-0c55b159cbfafe1f0" # Kali Linux AMI
  instance_type = "t2.micro"
  subnet_id = "subnet-id" # Replace with your subnet ID
  key_name      = "your-key-pair-name" # Replace with your key pair name

  tags = {
    Name = "KaliLinuxInstance"
  }
}