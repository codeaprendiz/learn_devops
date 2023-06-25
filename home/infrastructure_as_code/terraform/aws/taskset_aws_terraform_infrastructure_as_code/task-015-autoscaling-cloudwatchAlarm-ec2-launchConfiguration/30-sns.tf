// Provides an SNS topic resource

resource "aws_sns_topic" "example-sns" {
  name         = "sg-sns"
  display_name = "example ASG SNS topic"
}

//Provides an AutoScaling Group with Notification support, via SNS Topics. Each of the notifications
//map to a Notification Configuration inside Amazon Web Services, and are applied to each AutoScaling Group you supply.
resource "aws_autoscaling_notification" "example-notify" {
  group_names = [aws_autoscaling_group.example-autoscaling.name]
  topic_arn     = aws_sns_topic.example-sns.arn
  notifications  = [
    "autoscaling:EC2_INSTANCE_LAUNCH",
    "autoscaling:EC2_INSTANCE_TERMINATE",
    "autoscaling:EC2_INSTANCE_LAUNCH_ERROR"
  ]
}
