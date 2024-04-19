#!/usr/bin/env bash
set -x
exec > >(tee /var/log/user-data.log|logger -t user-data -s 2>/dev/console) 2>&1
export PATH="$PATH:/usr/bin"
sleep 1
cd /terraform/vm
terraform apply --auto-approve
cd ../app_service
terraform apply --auto-approve