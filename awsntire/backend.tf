terraform {
  backend "s3" {
            bucket            = "badalbks"
            key               = "global/ntier/terraform.tfstate"  
            region            = "us-east-2"
            dynamodb_table    = "qttableforterraformlock"
  }
  
  
}
