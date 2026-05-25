#!/bin/bash
cd "$(dirname "$0")"
./ryvex --algo autolykos2 --pool stratum+tcp://ergo-eu1.nanopool.org:10600 --wallet YOUR_ERG_WALLET.rig1
