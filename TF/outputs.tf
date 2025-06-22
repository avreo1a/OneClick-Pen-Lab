

#GENERAL INFORMATION
output "kali_instance_id" {
  description = "Kali EC2 Instance ID"
  value       = aws_instance.kali.id
}

output "kali_public_ip" {
  description = "Kali EC2 Public IP"
  value       = aws_instance.kali.public_ip
}

output "dvwa_instance_id" {
  description = "DVWA EC2 Instance ID"
  value       = aws_instance.dvwa.id
}

output "dvwa_public_ip" {
  description = "DVWA EC2 Public IP"
  value       = aws_instance.dvwa.public_ip
}

output "Elastic_IP" {
  description = "Elastic IP for DVWA Instance"
  value       = aws_eip.nat_gateway_eip.public_ip
}



#ACCESS TO SERVERS
output "ssh_to_kali" {
  description = "SSH command to access Kali Server"
  value       = "ssh -i ~/.ssh/your-key.pem ubuntu@${aws_instance.kali.public_ip}"
}

output "access_dvwa_url" {
  description = "URL to access DVWA web interface"
  value       = "http://${aws_instance.dvwa.public_ip}"
}
