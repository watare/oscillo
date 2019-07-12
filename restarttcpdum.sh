#!/bin/bash
tcpdown="$(docker ps -f "status=exited"|grep 'tcpdump')"
[ ! -z "$tcpdown" ] && /usr/bin/docker restart tcpdump
