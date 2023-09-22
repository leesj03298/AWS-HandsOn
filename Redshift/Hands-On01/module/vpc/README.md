# Terraform AWS Module - LEE SEUNG JOON : VPC

## Create AWS Resource List
- 
## Example Template
```HCL
module "vpc" {
    source  = "../module/vpc"
    vpc     = [
        {
            vpc_name                = "vpc-an2-sha-dev"
            cidr_block              = "10.10.0.0/25"
            igw_enable              = true
            igw_name                = "igw-an2-sha-dev"
            subnets         = [
                {   subnet_name = "sub-an2-sha-dev-pub-01a",  availability_zone  = "ap-northeast-2a", cidr_block = "10.10.0.0/27",   route_table_name = "rtb-an2-sha-dev-pub" },
                {   subnet_name = "sub-an2-sha-dev-pub-01c",  availability_zone  = "ap-northeast-2c", cidr_block = "10.10.0.32/27",  route_table_name = "rtb-an2-sha-dev-pub" },
                {   subnet_name = "sub-an2-sha-dev-pri-01a",  availability_zone  = "ap-northeast-2a", cidr_block = "10.10.0.64/27",  route_table_name = "rtb-an2-sha-dev-pri" },
                {   subnet_name = "sub-an2-sha-dev-pri-01c",  availability_zone  = "ap-northeast-2c", cidr_block = "10.10.0.96/27",  route_table_name = "rtb-an2-sha-dev-pri" },
            ]
        }
    ]
}
```