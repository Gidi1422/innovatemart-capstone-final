resource "aws_db_instance" "catalog" {
  allocated_storage    = 20
  engine               = "postgres"
  engine_version       = "15"
  instance_class       = "db.t3.micro"
  db_name              = "catalogdb"
  username             = "dbadmin"
  password             = "BedrockPass123!" 
  skip_final_snapshot  = true
  vpc_security_group_ids = [aws_security_group.rds_sg.id]
  
  tags = { Project = "Bedrock" }
}

resource "aws_security_group" "rds_sg" {
  name   = "project-bedrock-rds-sg"
  vpc_id = module.vpc.vpc_id
  ingress {
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/16"]
  }
}