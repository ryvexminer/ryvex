#!/bin/bash
cd "$(dirname "$0")"
./ryvex --algo kawpow --pool stratum+ssl://rvn.suprnova.cc:6275 --wallet YOUR_RVN_WALLET.rig1
