/**
  * We will utilize ELB and allow web access only from ELB
  */
resource "aws_security_group" "hs_albs_sg" {
    name = "${var.name_prefix}_${var.environment}_albs_sg"
    vpc_id = var.vpc_id
    description = "Security group for ALBs"

    dynamic "ingress" {
        iterator = port
        for_each = var.ingress_ports
        content {
            from_port   = port.value
            to_port     = port.value
            protocol    = "tcp"
            cidr_blocks = ["0.0.0.0/0"]
        }
    }

    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }

    lifecycle {
        create_before_destroy = true
    }

    tags = {
        Name = "${var.name_prefix}_${var.environment}_albs_sg"
    }
}

/**
  * Security group for each instances
  */
resource "aws_security_group" "hs_instances_sg" {
    name = "${var.name_prefix}-${var.environment}-webapp-instances"
    vpc_id = var.vpc_id
    description = "Security group for instances"

    lifecycle {
        create_before_destroy = true
    }

    tags = {
        Name = "${var.name_prefix}_${var.environment}_instances_sg"
    }
}

/* Allow all outgoing connections */
resource "aws_security_group_rule" "allow_all_egress" {
    type = "egress"
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]

    security_group_id = aws_security_group.hs_instances_sg.id
}

/* Allow incoming requests from ELB and peers only */
resource "aws_security_group_rule" "allow_all_from_albs" {
    type = "ingress"
    from_port = 0
    to_port = 0
    protocol = "-1"

    security_group_id = aws_security_group.hs_instances_sg.id
    source_security_group_id = aws_security_group.hs_albs_sg.id
}

resource "aws_security_group_rule" "allow_all_from_peers" {
    type = "ingress"
    from_port = 0
    to_port = 0
    protocol = "-1"

    security_group_id = aws_security_group.hs_instances_sg.id
    source_security_group_id = aws_security_group.hs_instances_sg.id
}

