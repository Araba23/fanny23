resource "aws_vpc" "Tenacity-vpc" {
  cidr_block       = var.vpc-cider
  instance_tenancy = "default"
  enable_dns_hostnames = true 
  enable_dns_support = true 

  tags = {
    Name = "Tenacity-vpc"
  }
}


# subnet
resource "aws_subnet" "Prod-pub-sub1" {
  vpc_id     = aws_vpc.Tenacity-vpc.id
  cidr_block = "10.0.1.0/24"

  tags = {
    Name = "Pro-pub-sub1"
  }
}


resource "aws_subnet" "Prod-pub-sub2" {
  vpc_id     = aws_vpc.Tenacity-vpc.id
  cidr_block = "10.0.2.0/24"

  tags = {
    Name = "Pro-pub-sub2"
  }
}


resource "aws_subnet" "Prod-priv-sub1" {
  vpc_id     = aws_vpc.Tenacity-vpc.id
  cidr_block = "10.0.3.0/24"

  tags = {
    Name = "Pro-priv-sub1"
  }
}


resource "aws_subnet" "Prod-priv-sub2" {
  vpc_id     = aws_vpc.Tenacity-vpc.id
  cidr_block = "10.0.4.0/24"

  tags = {
    Name = "Pro-priv-sub2"
  }
}

# route table
resource "aws_route_table" "Prod-pub-route-table" {
  vpc_id = aws_vpc.Tenacity-vpc.id

  tags = {
    Name = "Prod-pub-route-table"
  }
}

resource "aws_route_table" "Prod-priv-route-table" {
  vpc_id = aws_vpc.Tenacity-vpc.id

  tags = {
    Name = "Prod-priv-route-table"
  }
}

# route association
resource "aws_route_table_association" "Prod-pub-route-1-association" {
  subnet_id      = aws_subnet.Prod-pub-sub1.id
  route_table_id = aws_route_table.Prod-pub-route-table.id
}

resource "aws_route_table_association" "Prod-pub-route-2-association" {
  subnet_id      = aws_subnet.Prod-pub-sub2.id
  route_table_id = aws_route_table.Prod-pub-route-table.id
}

resource "aws_route_table_association" "Prod-priv-route-1-association" {
  subnet_id      = aws_subnet.Prod-priv-sub1.id
  route_table_id = aws_route_table.Prod-priv-route-table.id
}

resource "aws_route_table_association" "Prod-priv-route-2-association" {
  subnet_id      = aws_subnet.Prod-priv-sub2.id
  route_table_id = aws_route_table.Prod-priv-route-table.id
}

# IGw
resource "aws_internet_gateway" "Prod-igw" {
  vpc_id = aws_vpc.Tenacity-vpc.id

  tags = {
    Name = "Prod-igw"
  }
}

resource "aws_route" "Prod-igw-association" {
  route_table_id            = aws_route_table.Prod-pub-route-table.id
  destination_cidr_block    = "0.0.0.0/0"
  gateway_id                = aws_internet_gateway.Prod-igw.id
}

# Elastic IP
resource "aws_eip" "Tenacity-EIP" {
}

#NAT Gateway
resource "aws_nat_gateway" "Prod-Nat-gateway" {
  allocation_id = aws_eip.Tenacity-EIP.id
  subnet_id     = aws_subnet.Prod-pub-sub2.id
  }

  resource "aws_route" "Prod-Nat-association" {
  route_table_id            = aws_route_table.Prod-priv-route-table.id
  destination_cidr_block    = "0.0.0.0/0"
  gateway_id                = aws_nat_gateway.Prod-Nat-gateway.id
}

resource "aws_security_group" "allow_tls" {
  name        = "allow_tls"
  description = "Allow TLS inbound traffic"
  #vpc_id      = aws_vpc.Tenacity-VPC.id

  ingress {
    description      = "TLS from VPC"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
   # cidr_blocks      = [aws_vpc.Tenacity-VPC.cidr_block]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow_tls"
  }
}  






