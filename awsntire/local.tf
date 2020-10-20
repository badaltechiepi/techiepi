locals {
  dbsubnets = ["db", "db2"] 
  public_subnet = lookup(var.accosiation, "public")
  private_subnet = lookup(var.accosiation, "private")
}