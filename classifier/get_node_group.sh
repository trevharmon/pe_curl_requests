#!/bin/bash

CONSOLE=$(puppet config print server)
NODE_GROUP=$1
RUBY=/opt/puppetlabs/puppet/bin/ruby

curl -s -X GET https://${CONSOLE}:4433/classifier-api/v1/groups \
  --cert $(puppet config print hostcert) \
  --key $(puppet config print hostprivkey) \
  --cacert $(puppet config print localcacert) \
  -H "Content-Type: application/json" \
  | $RUBY -p -e "gsub(/^(\[.*|.+},)({.+\"name\":\"${NODE_GROUP}\".+?}})(,{|\]).+$/, \"\\\\2\")" \
  | python -m json.tool
