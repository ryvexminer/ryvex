#!/bin/bash
cd "$(dirname "$0")"
./ryvex --algo kawpow --pool stratum+tcp://pool.woolypooly.com:55555 --wallet YOUR_RVN_WALLET.rig1
