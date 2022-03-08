variable "aws_region" {
  type        = string
  description = "Region for AWS Resources"
  default     = "us-east-1"
}

variable "profile" {
  type        = string
  description = "Local IAM profile"
  default     = "terraform"
}

variable "targets" {
  type        = list(string)
  description = "Targets resources"
  default     = []
}

variable "instance_type" {
  type        = string
  description = "EC2 instance type"
  default     = "t3.small"
}

variable "key_path" {
  type        = string
  description = "Public key for SSH connection"
  default     = "~/.ssh/id_rsa.pub"
}

variable "duration" {
  type        = number
  description = "Duration of execution"
  default     = 3600
}

variable "db1000n_count" {
  type        = number
  description = "db1000n instance count"
  default     = 3
}

variable "instance_user" {
  type    = string
  default = "ubuntu"
}
