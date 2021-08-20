resource "aws_vpc_peering_connection" "hrdd_manage_to_app_peering" {
  peer_vpc_id   = var.vpc_from
  vpc_id        = var.vpc_to
  auto_accept   = true

  tags = {
    Name = "VPC Peering between manage and app"
  }
}