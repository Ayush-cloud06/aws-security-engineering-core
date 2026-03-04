resource "aws_security_group_rule" "app_to_db" {

  type = "egress"

  from_port = 5432
  to_port   = 5432
  protocol  = "tcp"

  security_group_id        = aws_security_group.app_sg.id
  source_security_group_id = aws_security_group.db_sg.id
}
