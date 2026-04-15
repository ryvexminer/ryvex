#!/bin/bash
cd "$(dirname "$0")"
./ryvex --algo kawpow --pool stratum+ssl://stratum.ravenminer.com:13801 --wallet YOUR_RVN_WALLET.rig1
