# 1. Manually define the Subnet Group to ensure it exists
resource "aws_db_subnet_group" "bedrock_db_subnets" {
  name       = "bedrock-database-subnet-group"
  subnet_ids = module.vpc.private_subnets # Connects to the private subnets from your VPC

  tags = {
    Project = "Bedrock"
  }
}

# 2. Updated RDS Instance
resource "aws_db_instance" "catalog" {
  allocated_storage      = 20
  engine                 = "mysql"
  engine_version         = "8.0"
  instance_class         = "db.t3.micro"
  db_name                = "catalogdb"
  username               = "dbadmin"
  password               = "BedrockPass123!" 
  skip_final_snapshot    = true
  
  # Reference the new subnet group created above
  db_subnet_group_name   = aws_db_subnet_group.bedrock_db_subnets.name
  
  vpc_security_group_ids = [aws_security_group.rds_sg.id]
  
  tags = { 
    Project = "Bedrock" 
  }
}

# 3. Security Group (No changes needed, but included for completeness)
resource "aws_security_group" "rds_sg" {
  name   = "project-bedrock-rds-sg"
  vpc_id = module.vpc.vpc_id

  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = [module.vpc.vpc_cidr_block]
  }

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