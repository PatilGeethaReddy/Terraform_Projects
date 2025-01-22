
resource "aws_guardduty_detector" "LZ-guard" {
  enable = true
  datasources {
    s3_logs {
      enable = true
    }
    kubernetes {
      audit_logs {
        enable = false
      }
    }
    malware_protection {
      scan_ec2_instance_with_findings {

        ebs_volumes {
          enable = true
        }
      }
    }
  }
}
resource "aws_cloudwatch_event_rule" "LZ-rule" {
  name        = var.cloudwatch_event_rule
  description = "Event rule for trigger sns topic from AWS Guard duty"
  event_pattern = jsonencode(
    {
      "source" : ["aws.guardduty"],
      "detail-type" : ["GuardDuty Finding"]
    }
  )
}

resource "aws_cloudwatch_event_target" "LZ-target" {
  rule      = aws_cloudwatch_event_rule.LZ-rule.name
  target_id = "SendToSNS"
  arn       = aws_sns_topic.LZ_sns.arn
  input_transformer {
    input_paths = {
      severity            = "$.detail.severity",
      Finding_ID          = "$.detail.id",
      Finding_Type        = "$.detail.type",
      region              = "$.region",
      Finding_description = "$.detail.description"
    }
    input_template = "\"You have a severity <severity> GuardDuty finding type <Finding_Type> in the <region> region.\"\n \"Finding Description:\" \"<Finding_description>. \"\n \"For more details open the GuardDuty console at https://console.aws.amazon.com/guardduty/home?region=<region>#/findings?search=id%3D<Finding_ID>\""
  }
}

resource "aws_sns_topic" "LZ_sns" {
  name =var.sns_topic
}

resource "aws_sns_topic_policy" "LZ-sns-policy" {
  arn    = aws_sns_topic.LZ_sns.arn
  policy = data.aws_iam_policy_document.LZ-policy-doc.json
}
data "aws_iam_policy_document" "LZ-policy-doc" {
  statement {
    effect  = "Allow"
    actions = ["SNS:Publish"]
    principals {
      type        = "Service"
      identifiers = ["events.amazonaws.com"]
    }
    resources = [aws_sns_topic.LZ_sns.arn]
  }
}


 