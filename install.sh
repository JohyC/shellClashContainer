#!/usr/bin/env bash

urls=(
  'https://raw.fastgit.org/juewuy/ShellClash/master'
  'https://fastly.jsdelivr.net/gh/juewuy/ShellClash@master'
  'https://shellclash.ga'
  'https://raw.githubusercontent.com/juewuy/ShellClash/master'
)

getInstall() {
  local http_code=-1
  local url=$1
  curl --connect-timeout 30 -w '%{http_code}' $url/install.sh -o /root/install.sh
  return $http_code
}

apt-get update &&
  apt-get install curl vim cron net-tools systemctl iptables -y &&
  chmod +x /install.sh

if [ $proxy ]; then
  export all_proxy=$proxy && export http_proxy=$all_proxy && export https_proxy=$all_proxy
else
  echo -e "\e[95m not set proxy! \e[0m"
fi

for i in ${urls[@]}; do
  if [ $(getInstall $i) = "200" ]; then
    mkdir -p ~/.local/share
    chmod 0755 ~/.local/share
    chmod +x /root/install.sh
    sh -c /root/install.sh
    echo -n "Enter your container docker of podman:"
    read container
    echo -e "\033[35mplease run:\033[0m
    \033[45;37m export runID=\$($container ps -a | grep shell_cash_container:1 | awk '{print \$1}') && $container start \$runID && $container exec -it \$runID /bin/bash\033[0m"
    echo -e "\033[35msetting clash run:\033[0m 
    \033[41;37msource /etc/profile\033[0m \033[35m\033[0m
    \033[41;37mclash\033[0m \033[35m\033[0m"
    break
  else
    echo "Fail"
  fi
done
