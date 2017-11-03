#!/bin/bash

# 2017 Jan Peschke j.peschke@syseleven.de

curl -sL https://deb.nodesource.com/setup_8.x | sudo -E bash -
apt-get install -y nodejs
## node -v
npm install @magnolia/cli -g
## npm update @magnolia/cli -g
## mgnl help
## mgnl tab-completion install
mgnl jumpstart
mgnl start
