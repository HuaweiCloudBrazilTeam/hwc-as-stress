data "huaweicloud_images_image_v2" "centos7" {
  name        = "CentOS 7.6 64bit"
  visibility  = "public"
  most_recent = true
}
