resource "aws_iam_user" "terraform-user" {
  name = var.iam-user_name
  tags = {
    creator = var.iam-user_name
  }
}
#create access key ID and secret key 
resource "aws_iam_access_key" "terraform-user_access_key" {
  user = aws_iam_user.terraform-user.name
}
output "access_key_id" {
  value = aws_iam_access_key.terraform-user_access_key
  sensitive = true
}
output "secret_access_key" {
  value = aws_iam_access_key.terraform-user_access_key.secret
  sensitive = true
}
locals {
  terraform-user_keys_csv = "access_key,secret_key\n${aws_iam_access_key.terraform-user_access_key.id},${aws_iam_access_key.terraform-user_access_key.secret}"
} 
resource "local_file" "terraform-user_keys" {
  content  = local.terraform-user_keys_csv
  filename = "terraform-user-keys.csv"
}
resource "aws_iam_group" "LZ-IAM-group" {
  name = var.iam-group-name
}
resource "aws_iam_group_membership" "terraform-user_membership" {
  name = aws_iam_user.terraform-user.name
  users = [aws_iam_user.terraform-user.name]
  group = aws_iam_group.LZ-IAM-group.name  
}
#administrator full
data "aws_iam_policy" "Administrator_full_access" {
  arn = "arn:aws:iam::aws:policy/AdministratorAccess"   
}
resource "aws_iam_group_policy_attachment" "LZ-IAM-group-Administrator-full-access" {
  policy_arn = data.aws_iam_policy.Administrator_full_access.arn
  group      = aws_iam_group.LZ-IAM-group.name
}