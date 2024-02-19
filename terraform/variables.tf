variable "do_token" {
  description = "DigitalOcean API token"
  type        = string
}

variable "pvt_key" {
  description = "Private key for SSH access"
  type        = string
  default     = ""
}

variable "region" {
  description = "DigitalOcean region"
  type        = string
  default     = "ams3"
}