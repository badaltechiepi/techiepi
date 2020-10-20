terraform {
  backend "s3" {
            bucket            = "qtforterraformstate2"
            key               = "global/ntier/terraform.tfstate"  
            region            = "us-east-2"
            dynamodb_table    = "qttableforterraformlock"
  }
  
  
}
