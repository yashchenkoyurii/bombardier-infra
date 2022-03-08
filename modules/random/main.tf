resource "random_integer" "int" {
  max = var.max_number
  min = var.min_number

  for_each = toset([for i in range(var.numbers_count) : tostring(i)])

  keepers = {
    timestamp = timestamp()
  }
}
