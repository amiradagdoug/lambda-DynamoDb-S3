# iam_role.tf

# Erstelle die Ausführungsrolle für Lambda mit Zugriff auf SQS
resource "aws_iam_role" "lambda_execution_role2" {
  name = "lambda-execution-role2"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "sts:AssumeRole",
        Effect = "Allow",
        Principal = {
          Service = "lambda.amazonaws.com"
        }
      }
    ]
  })
}

# Füge der Ausführungsrolle die Berechtigung hinzu, auf die SQS-Warteschlange zuzugreifen
resource "aws_iam_policy" "sqs_access_policy2" {
  name = "sqs-access-policy2"

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action   = "sqs:*",
        Effect   = "Allow",
        Resource = aws_sqs_queue.terraform_queue.arn # Beachten Sie, dass "aws_sqs_queue.my_queue" auf die SQS-Warteschlange in Ihrer `main.tf` Datei verweist
      }
    ]
  })
}

# Füge der Lambda-Ausführungsrolle die SQS-Berechtigungspolitik hinzu
resource "aws_iam_role_policy_attachment" "sqs_access" {
  policy_arn = aws_iam_policy.sqs_access_policy2.arn
  role       = aws_iam_role.lambda_execution_role2.name
}
