resource "aws_cloudwatch_dashboard" "dashboard" {
  dashboard_name = var.dashboard_name
  dashboard_body = jsonencode({
    widgets = [
      {
        "type": "metric",
        "x": 0,
        "y": 0,
        "width": 12,
        "height": 6,
        "properties": {
          "title": "EC2 - CPU Utilization (ASG)",
          "metrics": [
            [ "AWS/EC2", "CPUUtilization", "AutoScalingGroupName", var.asg_name ]
          ],
          "period": 300,
          "stat": "Average",
          "region": var.region
        }
      },
      {
        "type": "metric",
        "x": 0,
        "y": 6,
        "width": 12,
        "height": 6,
        "properties": {
          "title": "RDS - CPU Utilization",
          "metrics": [
            [ "AWS/RDS", "CPUUtilization", "DBInstanceIdentifier", var.rds_identifier ]
          ],
          "period": 300,
          "stat": "Average",
          "region": var.region
        }
      },
      {
        "type": "text",
        "x": 12,
        "y": 0,
        "width": 12,
        "height": 4,
        "properties": {
          "markdown": "# Dashboard Lab4\n\nMétricas agregadas de todas las instancias EC2 del ASG y de la(s) instancia(s) RDS."
        }
      }
    ]
  })
}
