resource "huaweicloud_compute_secgroup_v2" "sg-asg-app-example" {
  name        = "sg-asg-app-example"
  description = "Security Group para APP Auto Scaling Group"

  rule {
    from_port   = 22
    to_port     = 22
    ip_protocol = "tcp"
    cidr        = "0.0.0.0/0"
  }

  rule {
    from_port   = 80
    to_port     = 80
    ip_protocol = "tcp"
    cidr        = "0.0.0.0/0"
  }
}