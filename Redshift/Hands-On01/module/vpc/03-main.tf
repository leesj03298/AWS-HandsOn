data "aws_region" "current" {}

### AWS VPC
resource "aws_vpc" "default" {
    for_each                = { for vpc in var.vpc : vpc.vpc_name => vpc }
    cidr_block              = each.value.cidr_block
    enable_dns_hostnames    = each.value.enable_dns_hostnames
    enable_dns_support      = each.value.enable_dns_support
    instance_tenancy        = each.value.instance_tenancy
    tags                    = merge(each.value.tags, { "Name" = each.key })
}

locals {
    vpc_id          = { for key, vpc in aws_vpc.default : key => vpc.id if length(aws_vpc.default) != 0 }
}

### AWS Internet Gateway 
resource "aws_internet_gateway" "default" {
    for_each                = { for igw in var.vpc : igw.igw_name => igw 
                                    if alltrue([igw.igw_enable, length(aws_vpc.default) != 0 ]) }
	vpc_id                  = local.vpc_id["${each.value.vpc_name}"]
    tags                    = merge(each.value.tags, { "Name" = each.key })
}

### AWS Subnet
resource "aws_subnet" "default" {
    for_each                = { for sub in local.subnets : sub.subnet_name => sub 
                                    if alltrue([length(aws_vpc.default) != 0, length(local.subnets) != 0]) }
    vpc_id                  = local.vpc_id["${each.value.vpc_name}"]
    availability_zone       = each.value.availability_zone
    cidr_block              = each.value.cidr_block
    tags                    = merge(each.value.tags, { "Name" = each.key })
}

locals {
    subnet_id = { for key, subnet in aws_subnet.default : key => subnet.id if length(aws_subnet.default) != 0 }
}

### AWS Route Table 
resource "aws_route_table" "default" {
    for_each                = { for rtb in local.route_tables : rtb.route_table_name => rtb 
                                    if alltrue([length(aws_vpc.default) != 0, length(local.route_tables) != 0 ]) }
    vpc_id                  = local.vpc_id[each.value.vpc_name]
    tags                    = merge(each.value.tags, { "Name" = each.key })
}
locals {
    route_table_id = { for key, route_table in aws_route_table.default : key => route_table.id if length(aws_route_table.default) != 0 }
}

### AWS Route Table Assocation Subnet
resource "aws_route_table_association" "default" {
    for_each                = { for rta in local.subnets : join("-", [rta.subnet_name, rta.route_table_name]) => rta 
                                    if alltrue([length(aws_route_table.default) != 0, length(local.route_tables) != 0]) }
    route_table_id          = local.route_table_id[each.value.route_table_name]
    subnet_id               = local.subnet_id[each.value.subnet_name]
}