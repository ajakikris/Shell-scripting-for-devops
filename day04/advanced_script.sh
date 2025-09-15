#!/bin/bash

# Variables – Customize these
AMI_ID="ami-0abcdef1234567890"    # Example AMI (use correct AMI ID for your region)
INSTANCE_TYPE="t2.micro"
KEY_NAME="your-key-pair-name"
SECURITY_GROUP="your-security-group-id"
SUBNET_ID="your-subnet-id"        # Optional, depends on your VPC setup

# Create EC2 Instance
echo "[INFO] Launching EC2 instance..."

aws ec2 run-instances \
    --image-id $AMI_ID \
    --instance-type $INSTANCE_TYPE \
    --key-name $KEY_NAME \
    --security-group-ids $SECURITY_GROUP \
    --subnet-id $SUBNET_ID \
    --count 1 \
    --tag-specifications 'ResourceType=instance,Tags=[{Key=Name,Value=MyEC2Instance}]'

if [ $? -eq 0 ]; then
    echo "[SUCCESS] EC2 instance launched successfully."
else
    echo "[ERROR] Failed to launch EC2 instance."
    exit 1
fi

