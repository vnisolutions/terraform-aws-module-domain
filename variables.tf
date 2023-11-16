variable "domain" {
  description = "Domain will be add to Route53"
  type        = string
  default     = "develop.vnisolutions.com"
}

variable "create_ses" {
  description = "Enable verify SES"
  type        = bool
  default     = false
}

variable "create_acm" {
  description = "Enable verify SES"
  type        = bool
  default     = false
}
