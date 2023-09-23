variable "vpc_id" {
    description = "The id of the VPC"
    type        = map(string)
}

variable "securitygroups" {
    type = list(object({
        vpc_name                = string
        securitygroups          = optional(list(object({
            security_group_name     = optional(string, null)
            description             = optional(string, "Security Group")
            tags                    = optional(map(string), null)
        })), null)
    }))
}