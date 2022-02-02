resource "aws_security_group" "sg-base" {
  vpc_id = aws_vpc.vpc-customer.id

  tags = {
    Name = "sg-base"
  }
}

resource "aws_security_group_rule" "ingress-rules" {
  count = length(var.ingress_rules)

  type              = "ingress"
  from_port         = var.ingress_rules[count.index].from_port
  to_port           = var.ingress_rules[count.index].to_port
  protocol          = var.ingress_rules[count.index].protocol
  cidr_blocks       = [var.ingress_rules[count.index].cidr_block]
  description       = var.ingress_rules[count.index].description
  security_group_id = aws_security_group.sg-base.id
}

resource "aws_security_group_rule" "egress-rules" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1" #semantically equivallent to "all"
  cidr_blocks      = ["0.0.0.0/0"]
  security_group_id = aws_security_group.sg-base.id
}