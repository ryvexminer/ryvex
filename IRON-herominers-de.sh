#!/bin/bash
cd "$(dirname "$0")"
./ryvex --algo fishhash --pool stratum+tcp://de.ironfish.herominers.com:1145 --wallet YOUR_IRON_WALLET.rig1
