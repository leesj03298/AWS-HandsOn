# Terraform AWS Module - LEE SEUNG JOON : Security Group

## Create AWS Resource List
- `aws_security_group`


## Example Template
```HCL
module "securitygroup" {
    source          = "../module/securitygroup"
    vpc_id          = local.vpc_id
    securitygroups  = [
        {
            vpc_name        = "vpc-an2-sha-dev"
            securitygroups  = [
                {
                    security_group_name     = "scg-an2-sha-dev-rs-01"
                    description             = "Redshift01 Security Group"
                }
            ]
        }
    ]
}
```