
# main.tf

# Definiere die AWS-Provider-Konfiguration
provider "aws" {
  region  = "eu-central-1" # Ändern Sie die Region nach Bedarf
  profile = "153386709997_Student"

}

# Erstelle die SQS-Warteschlange
resource "aws_sqs_queue" "terraform_queue" {
  name                      = "terraform-example-queue"
  delay_seconds             = 90
  max_message_size          = 2048
  message_retention_seconds = 86400
  receive_wait_time_seconds = 10
}

# Erstelle die Queue-Richtlinie
resource "aws_iam_policy" "my_queue_policy" {
  name = "my_queue_policy"
  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Sid" : "VisualEditor0",
        "Effect" : "Allow",
        "Action" : "sqs:*",
        "Resource" : "*"
      }
    ]
  })
}


resource "aws_iam_role_policy_attachment" "attach_iam_policy_to_iam_role" {
  role       = aws_iam_role.lambda_execution_role2.name
  policy_arn = aws_iam_policy.my_queue_policy.arn
}

# Terraform-Ausgabe für die Queue-URL
output "queue_url1" {
  value = aws_sqs_queue.terraform_queue.id
}

