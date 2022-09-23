locals {
  health_check_route = var.health_check_route == null ? "/health" : var.health_check_route
}
