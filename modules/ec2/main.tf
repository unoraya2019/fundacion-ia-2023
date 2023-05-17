resource "aws_instance" "ec2" {
  ami                         = var.ami_id
  instance_type               = var.instance_type
  associate_public_ip_address = var.associate_public_ip_address
  subnet_id                   = var.subnet_id
  vpc_security_group_ids      = var.vpc_security_group_ids
  iam_instance_profile        = "ec2-ssm-profile"
  root_block_device {
    delete_on_termination = true
    iops                  = 3000
    tags = {
      Name = "ec2-bastion.${var.domain_app}"
    }
    throughput  = 125
    volume_size = var.volume_size
    volume_type = "gp3"
  }
  tags = {
    Name = "ec2-bastion"
  }
  depends_on = [
    aws_iam_instance_profile.ec2_ssm_profile
  ]
}
