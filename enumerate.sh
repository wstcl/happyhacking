#!/bin/bash
nmap -sV -sC $1 >> nmap_scan/$1
nmap -p- $1 >> nmap_scan/$1 &

if grep -q "80/tcp[[:blank:]]*open" "nmap_scan/$1"; then
	dirb http://$1 /usr/share/seclists/Discovery/Web-Content/big.txt -o dirb_scan/$1
	nikto -h $1 
fi

if grep -q "443/tcp[[:blank:]]*open" "nmap_scan/$1"; then
	dirb https://$1 /usr/share/seclists/Discovery/Web-Content/big.txt -o dirb_scan/$1_https
	nikto -h https://$1 
fi

