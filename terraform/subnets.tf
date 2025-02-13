// Conditionally retrieve AZs from AWS if not using LocalStack
data "aws_availability_zones" "available" {
  count = var.use_localstack ? 0 : 1
}

locals {
  // Use default AZs when LocalStack is enabled; otherwise, use those retrieved from AWS.
  availability_zones = var.use_localstack ? var.default_availability_zones : data.aws_availability_zones.available[0].names
}

resource "aws_subnet" "public" {
  count                   = var.use_localstack ? 0 : length(local.availability_zones)
  vpc_id                  = aws_vpc.main[0].id
  cidr_block              = cidrsubnet(aws_vpc.main[0].cidr_block, 8, count.index)
  availability_zone       = local.availability_zones[count.index]
  map_public_ip_on_launch = true
}
