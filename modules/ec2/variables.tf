variable "instance_type" {
  type        = string
  description = "Type for EC2 Instance"
}

variable "key_pair_id" {
  type        = string
  description = "Public key for SSH connection"
}

variable "instance_ami_id" {
  type        = string
  description = "AMI for instance"
}

variable "instance_root_device_size" {
  type        = number
  description = "Root device size in GB"
  default     = 8
}

variable "security_group_ids" {
  type        = list(string)
  description = "Security group ids applied for vpc"
}

variable "user_data" {
  type        = string
  description = "Init instance script"
}

variable "common_tags" {
  type        = object({})
  description = "Common tags"
  default = {
    managedBy : "terraform"
  }
}
