
resource "aws_security_group" "hs_db_sg" {
  vpc_id = var.vpc_id
  name = "${var.name_prefix}_${var.environment}_db_sg"
  description = "security group that allows all inboud traffic to db"

  dynamic "ingress" {
    iterator = port
    for_each = var.ingress_ports
    content {
      from_port   = port.value
      to_port     = port.value
      protocol    = "tcp"
      cidr_blocks = ["${lookup(var.cidr_vpc, var.environment)}.0/25"]
    }
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.name_prefix}_${var.environment}_db_sg"
  }
}

resource "aws_db_subnet_group" "hs_db_subnet_gp" {
  name       = "${var.name_prefix}-${var.environment}-subnet-gp"
  subnet_ids = var.subnet_ids_pri

  tags = {
    Name = "${var.name_prefix}-${var.environment}-subnet-gp"
  }
}

# Get latest snapshot from production DB
data "aws_db_snapshot" "hs_db_snapshot" {
  db_instance_identifier = var.db_instance_id
  db_snapshot_identifier = var.db_snapshot_id
}

resource "aws_db_instance" "hs_db" {
  instance_class       = "db.t2.micro"
  identifier           = "${var.name_prefix}-${var.environment}-db"
  username             = var.username
  password             = var.password
  db_subnet_group_name = aws_db_subnet_group.hs_db_subnet_gp.name
  snapshot_identifier  = data.aws_db_snapshot.hs_db_snapshot.id
  vpc_security_group_ids = [aws_security_group.hs_db_sg.id]
  skip_final_snapshot = true
}