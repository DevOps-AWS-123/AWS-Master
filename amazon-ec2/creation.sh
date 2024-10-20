#AWS Services Creation Shell Scripts
#1. Create an EC2 Instance
#!/bin/bash

# Variables
REGION="us-east-1" # Change this to your preferred region
INSTANCE_TYPE="t2.micro"
KEY_NAME="your-key-pair" # Change this to your key pair name
SECURITY_GROUP="your-security-group" # Change this to your security group name

# Create EC2 Instance
INSTANCE_ID=$(aws ec2 run-instances --image-id ami-0c55b159cbfafe1f0 --count 1 \
  --instance-type $INSTANCE_TYPE --key-name $KEY_NAME --security-groups $SECURITY_GROUP \
  --region $REGION --query 'Instances[0].InstanceId' --output text)

echo "EC2 Instance created with ID: $INSTANCE_ID"

#2. Create an S3 Bucket
#!/bin/bash

# Variables
BUCKET_NAME="your-unique-bucket-name" # Change this to a unique bucket name
REGION="us-east-1" # Change this to your preferred region

# Create S3 Bucket
aws s3api create-bucket --bucket $BUCKET_NAME --region $REGION \
  --create-bucket-configuration LocationConstraint=$REGION

echo "S3 Bucket created: $BUCKET_NAME"

#3. Create an RDS Database Instance
#!/bin/bash

# Variables
DB_INSTANCE_IDENTIFIER="mydbinstance"
DB_INSTANCE_CLASS="db.t2.micro"
DB_ENGINE="mysql"
DB_NAME="mydb"
MASTER_USERNAME="admin"
MASTER_PASSWORD="yourpassword" # Change this to a secure password
ALLOCATED_STORAGE=20 # In GB
REGION="us-east-1" # Change this to your preferred region

# Create RDS Instance
aws rds create-db-instance --db-instance-identifier $DB_INSTANCE_IDENTIFIER \
  --db-instance-class $DB_INSTANCE_CLASS --engine $DB_ENGINE \
  --master-username $MASTER_USERNAME --master-user-password $MASTER_PASSWORD \
  --allocated-storage $ALLOCATED_STORAGE --region $REGION \
  --db-name $DB_NAME

echo "RDS Database Instance created: $DB_INSTANCE_IDENTIFIER"

#4. Create a VPC
#!/bin/bash

# Variables
VPC_CIDR_BLOCK="10.0.0.0/16"
REGION="us-east-1" # Change this to your preferred region

# Create VPC
VPC_ID=$(aws ec2 create-vpc --cidr-block $VPC_CIDR_BLOCK --region $REGION \
  --query 'Vpc.VpcId' --output text)

echo "VPC created with ID: $VPC_ID"

#5. Create a Security Group
#!/bin/bash

# Variables
GROUP_NAME="my-security-group"
DESCRIPTION="My security group"
VPC_ID="your-vpc-id" # Replace with your VPC ID
REGION="us-east-1" # Change this to your preferred region

# Create Security Group
SECURITY_GROUP_ID=$(aws ec2 create-security-group --group-name $GROUP_NAME \
  --description "$DESCRIPTION" --vpc-id $VPC_ID --region $REGION \
  --query 'GroupId' --output text)

echo "Security Group created with ID: $SECURITY_GROUP_ID"

