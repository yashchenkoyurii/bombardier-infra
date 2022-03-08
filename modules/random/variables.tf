variable "max_number" {
  type = number
  description = "Max random number"
}

variable "min_number" {
  type = number
  default = 0
  description = "Min random number"
}

variable "numbers_count" {
  type = number
  description = "Number of generated numbers"
}
