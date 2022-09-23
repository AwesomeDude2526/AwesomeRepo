#AWS_VPC
resource "aws_vpc" "prod_vpc" {
  cidr_block = var.aws_vpc_cidr

  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = "${var.project}-vpc"
  }
}

# Public Subnet
resource "aws_subnet" "public_subnet" {
  count = var.availability_zones_count

  vpc_id            = aws_vpc.prod_vpc.id
  cidr_block        = cidrsubnet(var.aws_vpc_cidr, var.aws_subnet_cidr, count.index)
  availability_zone = data.aws_availability_zones.available.names[count.index]

  tags = {
    Name = "${var.project}-public-subnet"
  }

  map_public_ip_on_launch = true
}

# Private Subnets
resource "aws_subnet" "private_subnet" {
  count = var.availability_zones_count

  vpc_id            = aws_vpc.prod_vpc.id
  cidr_block        = cidrsubnet(var.aws_vpc_cidr, var.aws_subnet_cidr, count.index + var.availability_zones_count)
  availability_zone = data.aws_availability_zones.available.names[count.index]

  tags = {
    Name = "${var.project}-private-subnet"
  }
}

# Internet Gateway
resource "aws_internet_gateway" "prod_igw" {
  vpc_id = aws_vpc.prod_vpc.id

  tags = {
    "Name" = "${var.project}-igw"
  }

  depends_on = [aws_vpc.prod_vpc]
}

# Route Table(s)
# Route the public subnet traffic through the IGW
resource "aws_route_table" "prod_public_route" {
  vpc_id = aws_vpc.prod_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.prod_igw.id
  }

  tags = {
    Name = "${var.project}-prod_public_route"
  }
}

# Route table and subnet associations
resource "aws_route_table_association" "public_subnet_access" {
  count = var.availability_zones_count

  subnet_id      = aws_subnet.public_subnet[count.index].id
  route_table_id = aws_route_table.prod_public_route.id
}

# NAT Elastic IP
resource "aws_eip" "prod_nat_eip" {
  vpc = true

  tags = {
    Name = "${var.project}-ngw-ip"
  }
}

# NAT Gateway
resource "aws_nat_gateway" "prod_nat_gateway" {
  allocation_id = aws_eip.prod_nat_eip.id
  subnet_id     = aws_subnet.public_subnet[0].id

  tags = {
    Name = "${var.project}-ngw"
  }
}

# Add route to route table
resource "aws_route" "prod_route_table" {
  route_table_id         = aws_route_table.prod_public_route.id
  nat_gateway_id         = aws_nat_gateway.prod_nat_gateway.id
  destination_cidr_block = "0.0.0.0/0"
}

# Security group for public subnet
resource "aws_security_group" "sg_public_subnet" {
  name   = "${var.project}-public-sg"
  vpc_id = aws_vpc.prod_vpc.id

  tags = {
    Name = "${var.project}-public-sg"
  }
}

# Security group traffic rules
resource "aws_security_group_rule" "sg_ingress_public_443" {
  security_group_id = aws_security_group.sg_public_subnet.id
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "sg_ingress_public_80" {
  security_group_id = aws_security_group.sg_public_subnet.id
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "sg_egress_public" {
  security_group_id = aws_security_group.sg_public_subnet.id
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
}

# Security group for data plane
resource "aws_security_group" "data_plane_sg" {
  name   = "${var.project}-Worker-sg"
  vpc_id = aws_vpc.prod_vpc.id

  tags = {
    Name = "${var.project}-Worker-sg"
  }
}

# Security group traffic rules
resource "aws_security_group_rule" "nodes" {
  description       = "Allow nodes to communicate with each other"
  security_group_id = aws_security_group.data_plane_sg.id
  type              = "ingress"
  from_port         = 0
  to_port           = 65535
  protocol          = "-1"
  cidr_blocks       = flatten([cidrsubnet(var.aws_vpc_cidr, var.aws_subnet_cidr, 0), cidrsubnet(var.aws_vpc_cidr, var.aws_subnet_cidr, 1), cidrsubnet(var.aws_vpc_cidr, var.aws_subnet_cidr, 2), cidrsubnet(var.aws_vpc_cidr, var.aws_subnet_cidr, 3)])
}

resource "aws_security_group_rule" "nodes_inbound" {
  description       = "Allow worker Kubelets and pods to receive communication from the cluster control plane"
  security_group_id = aws_security_group.data_plane_sg.id
  type              = "ingress"
  from_port         = 1025
  to_port           = 65535
  protocol          = "tcp"
  cidr_blocks       = flatten([cidrsubnet(var.aws_vpc_cidr, var.aws_subnet_cidr, 2), cidrsubnet(var.aws_vpc_cidr, var.aws_subnet_cidr, 3)])
}

resource "aws_security_group_rule" "node_outbound" {
  security_group_id = aws_security_group.data_plane_sg.id
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
}

# Security group for control plane
resource "aws_security_group" "control_plane_sg" {
  name   = "${var.project}-controlplane-sg"
  vpc_id = aws_vpc.prod_vpc.id

  tags = {
    Name = "${var.project}-controlplane-sg"
  }
}

# Security group traffic rules
resource "aws_security_group_rule" "control_plane_inbound" {
  security_group_id = aws_security_group.control_plane_sg.id
  type              = "ingress"
  from_port         = 0
  to_port           = 65535
  protocol          = "tcp"
  cidr_blocks       = flatten([cidrsubnet(var.aws_vpc_cidr, var.aws_subnet_cidr, 0), cidrsubnet(var.aws_vpc_cidr, var.aws_subnet_cidr, 1), cidrsubnet(var.aws_vpc_cidr, var.aws_subnet_cidr, 2), cidrsubnet(var.aws_vpc_cidr, var.aws_subnet_cidr, 3)])
}

resource "aws_security_group_rule" "control_plane_outbound" {
  security_group_id = aws_security_group.control_plane_sg.id
  type              = "egress"
  from_port         = 0
  to_port           = 65535
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
}
