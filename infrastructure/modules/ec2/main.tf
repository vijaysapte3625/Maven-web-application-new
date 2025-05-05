resource "aws_instance" "this" {
  ami           = "ami-0c55b159cbfafe1f0" 
  instance_type = "t2.micro"
  subnet_id     = var.subnet_id
  security_groups = var.security_group_ids

  tags = {
    Name = "NexusServer"
  }
}

output "public_ip" {
  value = aws_instance.this.public_ip
}
