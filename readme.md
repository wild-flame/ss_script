## 配置新服务器的步骤

1. 安装 docker 

2. 将配置脚本上传到服务器 
  
    $ scp server.tar.gz 

3. 配置 ssh-key


    $ cat ~/.ssh/id_rsa.pub | ssh USER@HOST "mkdir -p ~/.ssh && cat >> ~/.ssh/authorized_keys"
    
或者
    
    $ ssh-copy-id -i ~/.ssh/mykey user@host

##  本地操作

进入 client 文件夹:

### 添加用户

```
$ ./addUser.sh PASSWD PORT LENGTH
```

```
$ ./addUser.sh 118.184.33.235 secret 2333 30
```

### 删除用户

```
$ ./deleteUser.sh PORT
```

```
$ ./deleteUser.sh 2333
```

