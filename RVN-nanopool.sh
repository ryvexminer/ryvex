#!/bin/bash
cd "$(dirname "$0")"
./ryvex --algo kawpow --pool stratum+ssl://rvn.nanopool.org:12643 --wallet YOUR_RVN_WALLET.rig1
