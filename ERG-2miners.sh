#!/bin/bash
cd "$(dirname "$0")"
./ryvex --algo autolykos2 --pool stratum+tcp://erg.2miners.com:8888 --wallet YOUR_ERG_WALLET.rig1
