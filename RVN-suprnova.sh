#!/bin/bash
cd "$(dirname "$0")"
./ryvex --algo kawpow --pool stratum+tcp://rvn.suprnova.cc:8888 --wallet YOUR_RVN_WALLET.rig1
