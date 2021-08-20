output "db_instance_snapshot" {
  description = "The address of the snapshot instance"
  value       = data.aws_db_snapshot.hs_db_snapshot.id
}

output "db_instance_address" {
  description = "The address of the db instance"
  value       = aws_db_instance.hs_db.id
}

output "rds_endpoint" {
  value = aws_db_instance.hs_db.address
}
