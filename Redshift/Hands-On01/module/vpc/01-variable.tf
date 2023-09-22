variable "vpc" {
    description = "Create Resource : VPC, Subnet, Route Tables(Subnet Associations)"
    type = list(object({
        vpc_name                                = string
        cidr_block                              = string
        igw_enable                              = optional(bool, false)
        igw_name                                = optional(string, null)
        enable_dns_hostnames                    = optional(bool, true)
        enable_dns_support                      = optional(bool, true)
        instance_tenancy                        = optional(string, "default")
        tags                                    = optional(map(string), null)
        subnets = optional(list(object({
            subnet_name                         = optional(string, null)
            availability_zone                   = optional(string, null)
            cidr_block                          = optional(string, null)
            route_table_name                    = optional(string, null)
            tags                                = optional(map(string), null)
        })), null)
    }))
}