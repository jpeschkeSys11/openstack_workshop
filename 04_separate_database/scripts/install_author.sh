#!/bin/bash
# 2017 j.peschke@syseleven.de

# reconfigure consul to act as a server
cat <<EOF> /etc/consul.d/consul.json
{
  "datacenter": "workshop01",
  "data_dir": "/tmp/consul",
  "bootstrap_expect": 1,
  "enable_script_checks": true,
  "retry_join": ["10.0.0.10"],
  "server": true
}
EOF

# restart consul
systemctl restart consul

echo "finished author core setup"
