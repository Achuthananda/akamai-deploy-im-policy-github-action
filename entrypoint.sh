#!/bin/bash
set -o pipefail

# Create /root/.edgerc file from env variable
echo -e "${EDGERC}" > ~/.edgerc

#  Set Variables
setPolicy=$1
policyList=$2
network=$3 #staging/production/both

# update zone using HTTPie and https://developer.akamai.com/api/cloud_security/edge_dns_zone_management/v2.html#postchangelistrecordsets

# check if zone file exists

for policyFile in $policyList; do
  if [ -f ${policyFile}.json ] ; then
    echo "Policy Json file exists: ${policyFile}.json"
  else
    echo -e "Error: ${policyFile}.json is missing.\nYou may want to add a file called ${policyFile}.json into the repository.\n"
    exit 123
  fi
done

for policyFile in $policyList; do
  # response=$(http edgeworkers list-ids --json --section edgeworkers --edgerc ~/.edgerc)
  echo "1. uploading policy file"
  mycommand1="akamai image-manager --section im --policy-set ${setPolicy} set-policy ${policyFile} --input-file ${policyFile}.json --network ${network}"
  echo "Running: $mycommand1"
  eval $mycommand1
done
