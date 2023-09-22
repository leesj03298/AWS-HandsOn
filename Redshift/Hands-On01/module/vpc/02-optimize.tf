locals {
    subnets         = flatten([ for vpc in var.vpc : [ 
                                    for subnet in vpc.subnets : merge(subnet, { "vpc_name" = vpc.vpc_name })
                            ] if alltrue([length(aws_vpc.default) != 0, length(vpc.subnets) != 0])
                        ])
    route_tables    = flatten([ for vpc in var.vpc : distinct([ 
                                    for subnet in vpc.subnets : merge(
                                        {"route_table_name" = subnet.route_table_name },
                                        {"vpc_name" = vpc.vpc_name },
                                        {"tags" = vpc.tags } 
                                    ) if subnet.route_table_name != null
                            ]) if alltrue([length(aws_vpc.default) != 0, length(vpc.subnets) != 0])
                        ])
}