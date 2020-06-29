#!/bin/bash

[ -f ~/.bash_ssh_settings ] && source ~/.bash_ssh_settings
# check that the info is still valid:
if ! ps -p $(echo $SSH_AGENT_PID) | grep -q 'ssh-agent' ; then
   ssh-agent | grep -v echo > ~/.bash_ssh_settings
   chmod 600 ~/.bash_ssh_settings
   source ~/.bash_ssh_settings
fi

port=5122

if [[ $(ip route | grep wlan0) ]] ; then
	if [[ ! $(ps auwx | grep -v grep | grep "/usr/lib/autossh") ]] ; then 
		autossh -f -M 0 -o "ServerAliveInterval 30" -o "ServerAliveCountMax 3" -o "ExitOnForwardFailure=yes"  -N -R ${port}:localhost:22 sk_edge_admin@dev.xal.no
	fi
fi

