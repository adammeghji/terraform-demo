resource "aws_instance" "tfdemo" {
    count = 5
    ami = "ami-5189a661"
    instance_type = "m3.medium"
    key_name = "tfdemo"

    connection {
      user = "ubuntu"
      key_file = "/Users/marms/.ssh/tfdemo.pem"
    }

    provisioner "remote-exec" {
      inline = [
        "sudo apt-get update",
        "sudo apt-get install -y nginx"
      ]
    }
}

resource "aws_elb" "frontend" {
    name = "frontend-load-balancer"
    availability_zones = ["us-west-2a", "us-west-2b", "us-west-2c"]
    listener {
        instance_port = 80
        instance_protocol = "http"
        lb_port = 80
        lb_protocol = "http"
    }
    instances = ["${aws_instance.tfdemo.*.id}"]

    health_check {
      healthy_threshold = 2
      unhealthy_threshold = 2
      timeout = 2
      target = "TCP:80"
      interval = 5
    }
}

resource "aws_route53_record" "tfdemo" {
  zone_id = "ZT0C35LV57KL2"
  name = "tfdemo.universe.com"
  type = "A"

  alias {
    name = "${aws_elb.frontend.dns_name}"
    zone_id = "${aws_elb.frontend.zone_id}"
    evaluate_target_health = false
  }
}
