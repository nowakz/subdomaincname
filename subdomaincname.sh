#!/bin/bash

if [[ $1 == "" || $2 == "" ]];then
	echo -e "
subdomaincname.sh \033[0;31m'\033[1;37mhost\033[0;31m' \033[0;31m'\033[1;37mwordlist\033[0;31m' '\033[1;37m--protocol (HTTP/HTTPS)\033[0;31m' '\033[1;37m--threads 110\033[0;31m'

	\033[1;37mUsage: [ \033[0;31m-p\033[1;37m or \033[0;31m--protocol\033[1;37m ] [ \033[0;31m-t\033[1;37m or \033[0;31m--threads\033[1;37m ]

			\033[0;31mex\033[1;37m : subdomaincname.sh fbi.gov /wordlist/subdomains.txt --protocol http
			\033[0;31mex\033[1;37m : subdomaincname.sh fbi.gov /wordlist/subdomains.txt --protocol https --threads 200

		";exit
fi

if [[ $6 == "" ]];then

	if [[ $4 == "http" || $4 == "HTTP" ]];then

		echo -e "\n\033[0;31m[\033[1;37m*\033[0;31m]\033[1;37m BRUTEFORCING \033[0;31m[\033[1;37m*\033[0;31m]\n"
		ffuf -u http://FUZZ.$1 -w $2 -s >> domains

		echo -e "\033[0;31mTrying Resolver CNAMES\033[1;37m\n"

		for domains in $(cat domains);do
			host -t cname $domains.$1
		done
		rm -f domains
		printf '\n'
	fi
fi

if [[ $6 == "" ]];then

        if [[ $4 == "https" || $4 == "HTTPS" ]];then

		echo -e "\n\033[0;31m[\033[1;37m*\033[0;31m]\033[1;37m BRUTEFORCING \033[0;31m[\033[1;37m*\033[0;31m]\n"
                ffuf -u https://FUZZ.$1 -w $2 -s >> domains

                echo -e "\033[0;31mTrying Resolver CNAMES\033[1;37m\n"

                for domains in $(cat domains);do
                        host -t cname $domains.$1
                done
                rm -f domains
                printf '\n'
        fi
fi

if [[ $6 != "" ]];then

        if [[ $4 == "http" || $4 == "HTTP" ]];then

		echo -e "\n\033[0;31m[\033[1;37m*\033[0;31m]\033[1;37m BRUTEFORCING \033[0;31m[\033[1;37m*\033[0;31m]\n"
                ffuf -u http://FUZZ.$1 -w $2 -t $6 -s >> domains

                echo -e "\033[0;31mTrying Resolver CNAMES\033[1;37m\n"

                for domains in $(cat domains);do
                        host -t cname $domains.$1
                done
                rm -f domains
                printf '\n'
        fi
fi

if [[ $6 != "" ]];then

        if [[ $4 == "https" || $4 == "HTTPS" ]];then

		echo -e "\n\033[0;31m[\033[1;37m*\033[0;31m]\033[1;37m BRUTEFORCING \033[0;31m[\033[1;37m*\033[0;31m]\n"
                ffuf -u https://FUZZ.$1 -w $2 -s >> domains

                echo -e "\033[0;31mTrying Resolver CNAMES\033[1;37m\n"

                for domains in $(cat domains);do
                        host -t cname $domains.$1
                done
                rm -f domains
                printf '\n'
        fi
fi



