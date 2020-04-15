output "ELB-IP-externo" {
  value = huaweicloud_elb_loadbalancer.elb-asg-app-example.vip_address
}
