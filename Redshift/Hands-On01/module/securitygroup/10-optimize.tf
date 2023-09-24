locals {
    security_groups         = distinct(flatten([ for securitygroup in var.securitygroups : [
                                            for scg in securitygroup.securitygroups : merge(scg, {"vpc_name" = securitygroup.vpc_name} )
                                            ]
                                        ]))
}