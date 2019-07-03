#!/bin/bash
tcpdump -i eth0 -w /var/tmp/trace-%m-%d-%H-%M.pcap -G 60
