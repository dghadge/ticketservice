#!/bin/bash

export AWS_DEFAULT_REGION=us-east-2

aws cloudformation delete-stack --stack-name ticketservice-vpc --profile labs

aws cloudformation delete-stack --stack-name ticketservice-eb --profile labs
