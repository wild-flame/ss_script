#!/bin/bash

echo "Hello I $(basename $0) is running..."
echo -n "May I ask the server-list filename (default:server.config):"
read serverLists

if test -z $serverListsFile
then 
  serverListsFile="server.config"
fi

printf "\e[94mReading file \"%s ...\"\n\e[0m" $serverListsFile

serverLists=`cat ${serverListsFile}`

secret="passwd"
port=-1
length=-1

function getPasswd() {
found=0;
for item in $@ ; do
  if [[ $found == 1 ]]; then
    secret=$item
    found=0;
    break;
  fi

  if [[ "$item" == "--secret" ]]; then
    found=1;
  fi
done
}

function getPort() {
found=0;
for item in $@ ; do
  if [[ $found == 1 ]]; then
    port=$item
    found=0;
    break;
  fi

  if [[ "$item" == "--port" ]]; then
    found=1;
  fi
done
}

function getLength() {
found=0;
for item in $@ ; do
  if [[ $found == 1 ]]; then
    length=$item
    break;
  fi

  if [[ "$item" == "--length" ]]; then
    found=1;
  fi
done
}

getPasswd $@
getPort $@
getLength $@

echo "serverLists is:"

if [[ $1 == "addUser" ]]; then

  for server in $serverLists; do
    printf "$server \e[32mSTART\e[0m\n"
    ssh $server "bash -s" < addUser.sh ${secret} ${port}
    # docker stop shadow_${port} | at now + ${length} days
    echo "Create user whose secret is ${secret}, Port is ${port}, length is ${length} days"
    printf "@$server \e[32mFinish\e[0m\n"
  done

  echo "正在生成服务器列表..."
  for server in $serverLists; do
    ip="$(cut -d'@' -f2 <<< "$server")"
    echo "服务器:$ip"
    echo "密码:$secret"
    echo "端口:$port"
    echo "加密方式:aes-256-cfb"
    echo "==="
  done
fi

if [[ $1 == "deleteUser" ]]; then

  for server in $serverLists; do
    printf "$server \e[32mSTART\e[0m\n"
    ssh $server "bash -s" < deleteUser.sh ${port}
    echo "Delete user whose secret is ${secret}, Port is ${port}, length is ${length} days"
    printf "@$server \e[32mFinish\e[0m\n"
  done

fi

