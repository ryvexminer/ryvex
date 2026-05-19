#!/bin/bash
cd "$(dirname "$0")"
./ryvex --algo kawpow --pool stratum+ssl://rvn.suprnova.cc:8889 --wallet YOUR_RVN_WALLET.rig1
