resource "aws_s3_bucket" "remote-state" {
    bucket = "terraform-remote-state-wale"
}

resource "aws_dynamodb_table" "terraform-remote-state" {
    name          = "terraform-remote-state"
    billing_mode = "PROVISIONED"
    read_capacity = 1
    write_capacity = 1
    hash_key = "LOCKID"

    attribute {
      name = "LOCKID"
      type = "S"
    }
}
