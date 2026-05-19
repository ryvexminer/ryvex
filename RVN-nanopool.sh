#!/bin/bash
cd "$(dirname "$0")"
./ryvex --algo kawpow --pool stratum+ssl://rvn-eu1.nanopool.org:10443 --wallet YOUR_RVN_WALLET.rig1
