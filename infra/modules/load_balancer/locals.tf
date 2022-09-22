locals {
  health_check_route = var.health_check_route == null ? "/api/v1/${var.name}/healthcheck" : var.health_check_route
}
