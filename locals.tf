# local variable definition: This is how you can combine variables to build out new variables
locals {
  baseName     = "${var.environment}${format("%02s", var.instance)}"
  baseInstance = format("%02s", var.instance)
}
