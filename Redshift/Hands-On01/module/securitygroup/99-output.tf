output "scg_id" {
    description = "The id of the Security Group"
    value = { for k,scg in aws_security_group.default : k => scg.id }
}