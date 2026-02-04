resource "aws_db_instance" "catalog" {
  allocated_storage      = 20
  engine                 = "mysql"        # Changed to MySQL for Catalog Service (Req 5.1)
  engine_version         = "8.0"          # Standard MySQL version
  instance_class         = "db.t3.micro"
  db_name                = "catalogdb"
  username               = "dbadmin"
  password               = "BedrockPass123!" 
  skip_final_snapshot    = true
  
  # Links the DB to your private VPC subnets
  db_subnet_group_name   = module.vpc.database_subnet_group_name
  vpc_security_group_ids = [aws_security_group.rds_sg.id]
  
  # Required Project Tag
  tags = { 
    Project = "Bedrock" 
  }
}

resource "aws_security_group" "rds_sg" {
  name   = "project-bedrock-rds-sg"
  vpc_id = module.vpc.vpc_id

  # Ingress: Allows access on MySQL port 3306 from within the VPC
  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = [module.vpc.vpc_cidr_block]
  }

  # Egress: Standard outbound allow-all
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = { 
    Project = "Bedrock" 
  }
}