# Create EC2 Instance
resource "aws_instance" "instance" {
  count                       = 2
  vpc_security_group_ids      = [aws_security_group.sg.id]
  subnet_id                   = aws_subnet.subnet[count.index].id
  instance_type               = var.instance_type
  ami                         = data.aws_ami.ubuntu22.id
  key_name                    = var.key_name
  availability_zone           = data.aws_availability_zones.available_zone.names[count.index]
  associate_public_ip_address = true
  depends_on                  = [aws_security_group.sg]
  tags = {
    "Name" = "${var.project}-${terraform.workspace}-instance"
  }

  root_block_device {
    delete_on_termination = true
    volume_size           = var.volume_size
    volume_type           = var.volume_type
  }
}

# EC2 Instance CloudWatch Dashboard 
resource "aws_cloudwatch_dashboard" "main_dashboard" {
  dashboard_name = "${var.project}-${terraform.workspace}-dashboard"

  dashboard_body = jsonencode({
    widgets = [
      {
        type   = "metric"
        x      = 0
        y      = 0
        width  = 12
        height = 6

        properties = {
          metrics = [
            [
              "AWS/EC2",
              "CPUUtilization",
              "InstanceId",
              "aws_instance.instance[*]id"
            ]
          ]
          period = 300
          stat   = "Average"
          region = var.region
          title  = "EC2 Instance CPU"
        }
      },
      {
        type   = "text"
        x      = 0
        y      = 7
        width  = 3
        height = 3

        properties = {
          markdown = "EC2 Instance Status"
        }
      }
    ]
  })
  depends_on = [aws_instance.instance]
}

# EC2 Instance CloudWatch Metric Alarm
resource "aws_cloudwatch_metric_alarm" "main_alarm" {
  alarm_name                = "${var.project}-alarm"
  comparison_operator       = "GreaterThanUpperThreshold"
  evaluation_periods        = 2
  threshold_metric_id       = "e1"
  alarm_description         = "This metric monitors ec2 cpu utilization"
  insufficient_data_actions = []

  metric_query {
    id          = "e1"
    return_data = true
    expression  = "ANOMALY_DETECTION_BAND(m1)"
    label       = "CPUUtilization (Expected)"
  }

  metric_query {
    id          = "m1"
    return_data = true
    metric {
      metric_name = "CPUUtilization"
      namespace   = "AWS/EC2"
      period      = 300
      stat        = "Average"
      unit        = "Count"

      dimensions = {
        InstanceId = "aws_instance.instance[*]id"
      }
    }
  }
  depends_on = [aws_instance.instance]
}