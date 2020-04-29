resource "huaweicloud_as_configuration_v1" "as-config-app-example" {
  lifecycle {
    create_before_destroy = true
  }
  scaling_configuration_name = "as-config-app-example"
  instance_config {
    flavor = var.ecs_flavor
    image  = data.huaweicloud_images_image_v2.centos7.id
    disk {
      size        = 40
      volume_type = "SATA"
      disk_type   = "SYS"
    }
    key_name  = var.keypair_name
    user_data = file("userdata.yaml")
  }
}

resource "huaweicloud_as_group_v1" "asg-app-example" {
  scaling_group_name       = "asg-app-example"
  scaling_configuration_id = huaweicloud_as_configuration_v1.as-config-app-example.id
  cool_down_time           = 30
  desire_instance_number   = 2
  min_instance_number      = 0
  max_instance_number      = 4
  vpc_id                   = var.vpc_id
  lb_listener_id           = huaweicloud_elb_listener.elb-asg-app-example-http.id
  delete_publicip          = true
  delete_instances         = "yes"

  networks {
    id = var.network_id
  }
  security_groups {
    id = huaweicloud_compute_secgroup_v2.sg-asg-app-example.id
  }
}

resource "huaweicloud_as_policy_v1" "as-policy-app-example-cpu50" {
  scaling_policy_name = "as-policy-app-example-cpu50"
  scaling_group_id    = huaweicloud_as_group_v1.asg-app-example.id
  cool_down_time      = 60
  scaling_policy_type = "ALARM"
  alarm_id            = huaweicloud_ces_alarmrule.alarm-asg-example-cpu50.id
  scaling_policy_action {
    operation       = "ADD"
    instance_number = 1
  }
}

resource "huaweicloud_ces_alarmrule" "alarm-asg-example-cpu50" {
  alarm_name = "alarm-asg-example-cpu50"
  metric {
    namespace   = "SYS.AS"
    metric_name = "cpu_util"
    dimensions {
      name  = "AutoScalingGroup"
      value = huaweicloud_as_group_v1.asg-app-example.id
    }
  }
  condition {
    period              = 60
    filter              = "average"
    comparison_operator = ">="
    value               = 60
    unit                = "%"
    count               = 1
  }
  alarm_actions {
    type              = "autoscaling"
    notification_list = []
  }
}