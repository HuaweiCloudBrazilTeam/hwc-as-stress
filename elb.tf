resource "huaweicloud_elb_listener" "elb-asg-app-example-http" {
  name             = "elb-asg-app-example-http"
  description      = "Listerner ELB for ASG APP Example"
  protocol         = "TCP"
  backend_protocol = "TCP"
  port             = 80
  backend_port     = 80
  lb_algorithm     = "roundrobin"
  loadbalancer_id  = huaweicloud_elb_loadbalancer.elb-asg-app-example.id
  timeouts {
    create = "5m"
    update = "5m"
    delete = "5m"
  }
}

resource "huaweicloud_elb_loadbalancer" "elb-asg-app-example" {
  name           = "elb-asg-app-example"
  type           = "External"
  description    = "ELB for ASG APP Example"
  vpc_id         = var.vpc_id
  admin_state_up = 1
  bandwidth      = 5
}

resource "huaweicloud_elb_healthcheck" "elb-healthcheck-asg-app-example" {
  listener_id          = huaweicloud_elb_listener.elb-asg-app-example-http.id
  healthcheck_uri      = "/"
  healthy_threshold    = 5
  healthcheck_timeout  = 5
  healthcheck_interval = 5
  timeouts {
    create = "5m"
    update = "5m"
    delete = "5m"
  }
}