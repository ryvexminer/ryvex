#!/bin/bash
cd "$(dirname "$0")"
./ryvex --algo autolykos2 --pool stratum+tcp://de.ergo.herominers.com:1180 --wallet YOUR_ERG_WALLET.rig1
