resource "aws_networkfirewall_firewall" "LZ-Firewall" {
  name                = var.aws_networkfirewall_firewall
  firewall_policy_arn = aws_networkfirewall_firewall_policy.LZ-firewall-policy.arn
  vpc_id              = var.vpc_id
  subnet_mapping {
    subnet_id = var.subnet_id
  }
  tags = {
    Tag1 = "Value1"
    Tag2 = "Value2"
  }
}
resource "aws_networkfirewall_firewall_policy" "LZ-firewall-policy" {
  name = var.aws_networkfirewall_firewall_policy
  firewall_policy {
    stateless_default_actions          = ["aws:pass", "ExampleCustomAction"]
    stateless_fragment_default_actions = ["aws:drop"]

    stateless_custom_action {
      action_definition {
        publish_metric_action {
          dimension {
            value = "1"
          }
        }
      }
      action_name = "ExampleCustomAction"
    }
  }
}



