resource "aws_ecs_cluster" "iac" {
  name = "${var.type}-${var.stage}-${var.group}-${var.project}"


  configuration {
    execute_command_configuration {
      kms_key_id = aws_kms_key.iac.arn
      logging    = "OVERRIDE"

      log_configuration {
        cloud_watch_encryption_enabled = true
        cloud_watch_log_group_name     = aws_cloudwatch_log_group.iac.name
      }
    }
  }

  setting {
    name  = "containerInsights"
    value = var.monitoring
  }
  tags = {
    "Name" = "${var.type}-${var.stage}-${var.group}-${var.project}"
  }
  depends_on = [
    aws_kms_key.iac, aws_kms_alias.iac
  ]
}


# KMS Key

resource "aws_kms_key" "iac" {
  description             = "kms-${var.type}-${var.stage}-${var.group}-${var.project}"
  deletion_window_in_days = 10
  #policy                  = file("./policies/policy-kms.json")
  policy = jsonencode(
    {
      Id = "key-default-1"
      Statement = [
        {
          Action = "kms:*"
          Effect = "Allow"
          Principal = {
            AWS = "arn:aws:iam::${var.account}:root"
          }
          Resource = "*"
          Sid      = "Enable IAM User Permissions"
        },
        {
          Action = [
            "kms:Encrypt*",
            "kms:Decrypt*",
            "kms:ReEncrypt*",
            "kms:GenerateDataKey*",
            "kms:Describe*",
          ]
          Effect = "Allow"
          Principal = {
            Service = "logs.${var.region}.amazonaws.com"
          }
          Resource = "*"
        },
      ]
      Version = "2012-10-17"
    }
  )
  tags = {
    "Name" = "kms-${var.type}-${var.stage}-${var.group}-${var.project}"
  }
}

resource "aws_kms_alias" "iac" {
  name          = "alias/kms-${var.type}-${var.stage}-${var.group}-${var.project}"
  target_key_id = aws_kms_key.iac.id
}

# Logs Cloudwatch

resource "aws_cloudwatch_log_group" "iac" {
  name       = "/ecs/${var.type}/${var.stage}/${var.group}/${var.project}"
  kms_key_id = aws_kms_key.iac.arn
  tags = {
    "Name" = "log-group-${var.type}-${var.stage}-${var.group}-${var.project}"
  }
}
