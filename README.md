Terraform All concept:
1. instllation of the terraform. 
   a. Search in Google, how to install the terraform in linux machine

2. 08-10: Terraform configuratin language
   a. Resources 
   b. Provider
   c. Block
   d. environment variable setup(export)
   e. Let's create a VPC with 4 subnet

3. 09-10:
   a. setting up the aws cli
   b. configure the provider for the aws
   c. making the below stuff generic
     - taking the input from the user for cidr_block
     - setting up the region by taking the input from the user(e.g. region) 
     - setting up the tags name 
     - making genaric the az by using the function
     - making genaric the subenet based on the cidr_block by using funciton
4. 10-10
    a. setting up the azure provider for terraform(export)
    b. create the resouce group
    c. create the vnet 
    d. create the subnet
    e. creating the a terraform template for both azure and aws(both)
    f. terraform depends on, this is coming because of the azure resources creation.  