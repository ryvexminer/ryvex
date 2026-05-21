#!/bin/bash
cd "$(dirname "$0")"
./ryvex --algo kawpow --pool stratum+tcp://ravencoin.herominers.com:10240 --wallet YOUR_RVN_WALLET.rig1
