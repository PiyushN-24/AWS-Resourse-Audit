#!/bin/bash

###############################################################################
# Author: Piyush Navghare
# Version: v0.1.0

# Script to automate the process of listing all the resources in an AWS account.
#
# Usage: ./GET_aws_resource_audit.sh <aws_region> <aws_service>
# Example: ./GET_aws_resource_audit.sh us-east-1 ec2
###############################################################################

# Check if the required number of arguments are passed
if [[ $# -lt 1 ]]; then
    echo "Usage: ./aws_resource_list.sh <aws_region> [aws_service|all]"
    echo "Example: ./aws_resource_list.sh us-east-1 ec2"
    exit 1
fi

aws_region=$1
aws_service=${2:-all}

# Check if the AWS CLI is installed
if ! command -v aws &> /dev/null; then
    echo "AWS CLI is not installed. Please install it and try again."
    exit 1
fi

# Check if AWS CLI is configured
if [ ! -d ~/.aws ]; then
    echo "AWS CLI is not configured. Please configure it and try again."
    exit 1
fi

# Set available services in an associative array
declare -A services=(
    [ec2]="aws ec2 describe-instances --region $aws_region"
    [rds]="aws rds describe-db-instances --region $aws_region"
    [s3]="aws s3api list-buckets"
    [cloudfront]="aws cloudfront list-distributions"
    [vpc]="aws ec2 describe-vpcs --region $aws_region"
    [iam]="aws iam list-users"
    [route53]="aws route53 list-hosted-zones"
    [cloudwatch]="aws cloudwatch describe-alarms --region $aws_region"
    [cloudformation]="aws cloudformation describe-stacks --region $aws_region"
    [lambda]="aws lambda list-functions --region $aws_region"
    [sns]="aws sns list-topics --region $aws_region"
    [sqs]="aws sqs list-queues --region $aws_region"
    [dynamodb]="aws dynamodb list-tables --region $aws_region"
    [ebs]="aws ec2 describe-volumes --region $aws_region"
)

# List available services if the user requests help or enters an invalid service
if [[ $aws_service == "-h" || $aws_service == "--help" ]]; then
    echo "Available services to list resources:"
    for service in "${!services[@]}"; do
        echo "  - $service"
    done
    echo "You can also use 'all' to list resources for all services in the specified region."
    exit 0
fi

# Function to list resources for a specific service
list_resources() {
    local service=$1
    local command=${services[$service]}
    
    echo "Listing $service resources in $aws_region..."
    
    if output=$($command 2>&1); then
        echo "$output" | jq . || echo "$output"
        echo "-------------------------------------"
    else
        echo "Error listing $service resources: $output"
    fi
}

# List resources based on user input
if [[ $aws_service == "all" ]]; then
    for service in "${!services[@]}"; do
        list_resources "$service"
    done
elif [[ -n ${services[$aws_service]} ]]; then
    list_resources "$aws_service"
else
    echo "Invalid service name: $aws_service"
    echo "Use --help to see a list of available services."
    exit 1
fi
