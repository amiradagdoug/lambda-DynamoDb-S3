# lambda.tf

# Erstelle die Lambda-Funktion
# lambda.tf

# Erstelle die Lambda-Funktion
resource "aws_lambda_function" "my_lambda1" {
  function_name = "my-lambda1"
  handler       = "lambda-code.handler" # Beachten Sie, dass "lambda-code" dem Namen Ihrer JavaScript-Datei entsprechen sollte
  runtime       = "nodejs14.x"
  filename      = "${path.module}/lambda-code.zip" # Hier wird der Pfad zur ZIP-Datei festgelegt
  role          = aws_iam_role.lambda_execution_role2.arn
}
# Erstelle den Lambda-Trigger für die SQS-Warteschlange
resource "aws_lambda_event_source_mapping" "sqs_trigger" {
  batch_size       = 5
  event_source_arn = aws_sqs_queue.terraform_queue.arn # Beachten Sie, dass "aws_sqs_queue.my_queue" auf die SQS-Warteschlange in Ihrer `main.tf` Datei verweist
  function_name    = aws_lambda_function.my_lambda1.arn
}
