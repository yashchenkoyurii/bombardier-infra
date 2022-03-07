output "numbers" {
  value = values(random_integer.int)[*].result
}
