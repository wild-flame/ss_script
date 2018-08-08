port=$1

echo "Stoping Dokcer at ${port}"
docker stop shadow${port}
echo "removing Dokcer at ${port}"
docker rm shadow${port}

