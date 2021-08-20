/* Security group */
output "hs_albs_sg_id" {
    value = aws_security_group.hs_albs_sg.id
}

output "hs_instances_sg_id" {
    value = aws_security_group.hs_instances_sg.id
}
