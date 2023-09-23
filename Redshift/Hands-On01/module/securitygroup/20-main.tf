### AWS Security Group
resource "aws_security_group" "default" {
    for_each            = { for scg in local.security_groups : scg.security_group_name => scg if length(local.security_groups) != 0 }
    vpc_id              = var.vpc_id[each.value.vpc_name]
    name                = each.value.security_group_name
    description         = each.value.description
    tags                = merge(each.value.tags, { "Name" = each.value.security_group_name })
    egress {
        from_port        = 0
        to_port          = 0
        protocol         = "-1"
        cidr_blocks      = ["0.0.0.0/0"]
        ipv6_cidr_blocks = ["::/0"]
    }
}