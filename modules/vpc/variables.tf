variable "common_tags" {
  type = object({})
  description = "Common tags"
  default = {
    managedBy : "terraform"
  }
}