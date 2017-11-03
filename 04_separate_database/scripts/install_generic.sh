#!/bin/bash
# 2017 j.peschke@syseleven.de

# install some useful stuff

# wait for a valid network configuration
until ping -c 1 syseleven.de; do sleep 5; done

export DEBIAN_FRONTEND=noninteractive
apt-get update
apt-get install -q -y -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold" curl haveged unzip wget jq git dnsmasq default-jre-headless

# add a system user for consul
adduser --quiet --shell /bin/sh --no-create-home --disabled-password --disabled-login --home /var/lib/misc --gecos "Consul system user" consul

# install consul and consul template
wget https://releases.hashicorp.com/consul/0.9.3/consul_0.9.3_linux_amd64.zip
wget https://releases.hashicorp.com/consul-template/0.19.3/consul-template_0.19.3_linux_amd64.zip
unzip consul_0.9.3_linux_amd64.zip
mv consul /usr/local/sbin/
rm consul_0.9.3_linux_amd64.zip
mkdir -p /etc/consul.d

unzip consul-template_0.19.3_linux_amd64.zip
mv consul-template /usr/local/sbin/
rm consul-template_0.19.3_linux_amd64.zip

# configure consul
cat <<EOF> /etc/consul.d/consul.json
{
  "datacenter": "workshop01",
  "data_dir": "/tmp/consul",
  "server": false,
  "retry_join": ["10.0.0.10"],
  "enable_script_checks": true
}
EOF

# install a systemd service file for consul
cat <<EOF> /etc/systemd/system/consul.service
[Unit]
Description=consul agent
Requires=network-online.target
After=network-online.target
[Service]
User=consul
EnvironmentFile=-/etc/default/consul
Environment=GOMAXPROCS=2
Restart=on-failure
ExecStart=/usr/local/sbin/consul agent \$OPTIONS -config-dir=/etc/consul.d
ExecReload=/bin/kill -HUP \$MAINPID
KillSignal=SIGINT
[Install]
WantedBy=multi-user.target
EOF

# enable and restart consul
systemctl enable consul
systemctl restart consul

# setup dnsmasq to communicate via consul
echo "server=/consul./127.0.0.1#8600" > /etc/dnsmasq.d/10-consul
systemctl restart dnsmasq

echo "finished generic core setup"
