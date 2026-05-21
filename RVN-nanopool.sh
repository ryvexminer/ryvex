#!/bin/bash
cd "$(dirname "$0")"
./ryvex --algo kawpow --pool stratum+tcp://rvn-eu1.nanopool.org:10400 --wallet YOUR_RVN_WALLET.rig1
