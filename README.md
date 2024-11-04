# AWS Resource Lister

![AWS](https://img.shields.io/badge/AWS-Cloud-orange?logo=amazon-aws&style=flat-square) 
![Shell Script](https://img.shields.io/badge/Script-Bash-blue?style=flat-square)

## Overview
**AWS Resource Lister** is a shell script that automates the process of listing various AWS resources across multiple services in a specified region. This tool is ideal for auditing and keeping track of resources such as EC2 instances, S3 buckets, VPCs, and more.

## Features
- Lists resources from multiple AWS services:
  - EC2, RDS, S3, CloudFront, VPC, IAM, Route53, CloudWatch, CloudFormation, Lambda, SNS, SQS, DynamoDB, EBS
- Supports dynamic service listing for easy extensibility
- Allows listing resources for a specific service or all services at once
- Provides readable JSON output with optional `jq` formatting
- Simple to use with minimal dependencies

## Prerequisites
- **AWS CLI** installed and configured with the necessary permissions.
- **jq** (optional) for pretty-printing JSON output.
- AWS credentials configured (use `aws configure` to set up access keys and default region).

## Usage
```bash
./aws_resource_list.sh <aws_region> <aws_service|all>

Arguments

    <aws_region>: AWS region code (e.g., us-east-1, eu-west-1).
    <aws_service>: (Optional) AWS service to list resources for. Use all to list resources for all supported services.

Examples

    List EC2 Instances in us-east-1:

    bash

./aws_resource_list.sh us-east-1 ec2

List all resources in us-west-2:

bash

    ./aws_resource_list.sh us-west-2 all

Supported Services

The script supports the following AWS services:

    Compute: EC2, Lambda
    Storage: S3, EBS
    Database: RDS, DynamoDB
    Networking: VPC, Route53, CloudFront
    Security: IAM
    Messaging: SNS, SQS
    Monitoring: CloudWatch
    Infrastructure Management: CloudFormation

For a complete list of supported services and usage instructions, run:

bash

./aws_resource_list.sh --help

Output

The script outputs JSON-formatted data for each service, making it easy to analyze or save to a file.

Example Output for EC2 Instances:

json

{
  "Reservations": [
    {
      "Instances": [
        {
          "InstanceId": "i-0123456789abcdef0",
          "InstanceType": "t2.micro",
          "State": {
            "Name": "running"
          },
          "PublicIpAddress": "54.123.45.67",
          ...
        }
      ]
    }
  ]
}

Troubleshooting

    AWS CLI Not Installed: Make sure the AWS CLI is installed and accessible in your PATH.
    AWS CLI Not Configured: Run aws configure to set up your AWS credentials.
    Invalid Service: Check the list of supported services in this README or by using the --help flag.

Contributing

Contributions, issues, and feature requests are welcome! Please feel free to submit a pull request or open an issue.
License

This project is licensed under the MIT License. See the LICENSE file for details.
