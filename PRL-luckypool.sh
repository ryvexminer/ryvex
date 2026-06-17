#!/bin/bash
cd "$(dirname "$0")"
./ryvex --algo pearl --pool stratum+tcp://pearl-eu1.luckypool.io:3360 --wallet YOUR_PRL_WALLET.rig1
