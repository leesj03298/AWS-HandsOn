locals {
    security_groups         = flatten([ for securitygroup in var.securitygroups : distinct([
                                            for scg in securitygroup.securitygroups : merge(scg, {"vpc_name" = securitygroup.vpc_name} )
                                            ])
                                        ])
}