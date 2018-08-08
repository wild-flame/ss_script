passwd=$1
port=$2

echo "Starting Dokcer at ${port}"
docker run --name shadow${port} -d -p ${port}:${port} oddrationale/docker-shadowsocks -s 0.0.0.0 -p ${port} -k $passwd -m aes-256-cfb
