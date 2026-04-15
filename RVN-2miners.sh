#!/bin/bash
cd "$(dirname "$0")"
./ryvex --algo kawpow --pool stratum+ssl://rvn.2miners.com:16060 --wallet YOUR_RVN_WALLET.rig1
