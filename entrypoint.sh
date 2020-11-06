#!/bin/bash
set -o pipefail

# Create /root/.edgerc file from env variable
echo -e "${EDGERC}" > ~/.edgerc

#  Set Variables
setPolicy=$1
policyName=$2
network=$3 #staging/production/both

# update zone using HTTPie and https://developer.akamai.com/api/cloud_security/edge_dns_zone_management/v2.html#postchangelistrecordsets

# check if zone file exists
if [ -f ${policyName}.json ] ; then
  echo "Policy Json file exists: ${policyName}.json"
else
  echo -e "Error: ${policyName}.json is missing.\nYou may want to add a file called ${policyName}.json into the repository with the contents similar to the one below:\n"
  #mycommand0="http --print=b -A edgegrid -a dns: GET :/config-dns/v2/zones/${policyName}/zone-file Accept:text/dns | grep -v \;\;"
  #eval $mycommand0 > output0
  #cat output0
  exit 123
fi

# response=$(http edgeworkers list-ids --json --section edgeworkers --edgerc ~/.edgerc)
echo "1. uploading policy file"
mycommand1="akamai image-manager --section im --policy-set ${setPolicy} set-policy ${policyName} --input-file ${policyName}.json --network ${network}"
echo "Running: $mycommand1"
eval $mycommand1
