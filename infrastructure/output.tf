output "nexus_instance_ip" {
  description = "The public IP of the Nexus EC2 instance"
  value       = module.ec2.public_ip
}
