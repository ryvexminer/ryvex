#!/bin/bash
cd "$(dirname "$0")"
./ryvex --algo autolykos2 --pool stratum+tcp://pool.woolypooly.com:3100 --wallet YOUR_ERG_WALLET.rig1
