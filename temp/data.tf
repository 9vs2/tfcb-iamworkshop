data "external" "lambda_to_zip" {
  program = ["sh", "zip.sh"]
  query = {
    input_path = "index.js"
    output_path = "lambda.zip"
  }
}