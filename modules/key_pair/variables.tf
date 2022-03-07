variable "common_tags" {
  type = object({})
  description = "Common tags"
  default = {
    managedBy : "terraform"
  }
}

variable "key_path" {
  type    = string
  description = "Public key for SSH connection"
}
