# programmable router for development

# build

```
$ docker build -t rapiter:latest .
```

# run

```
$ docker run -p 80:4567 rapiter:latest
```

# add backend

```
$ docker run nginx:1.7.9

$ docker ps
CONTAINER ID        IMAGE               COMMAND                CREATED             STATUS              PORTS                  NAMES
2cb11406a0c4        nginx:1.7.9         "nginx -g 'daemon of   19 seconds ago      Up 18 seconds       443/tcp, 80/tcp        naughty_kowalevski
484fbbc49f1b        rapiter:latest      "bundle exec ruby ap   6 minutes ago       Up 6 minutes        0.0.0.0:80->4567/tcp   focused_mayer

$ docker inspect --format '{{ .NetworkSettings.IPAddress  }}' 2cb11406a0c4
172.17.0.37


$ curl -X "POST" "http://xxx.b2d" -d "{\"nginx\":\"http://172.17.0.37/\"}"
{"nginx":"http://172.17.0.37/"}
```

open 'http://nginx.b2d'

# remove backend

```
$ curl -X "DELETE" "http://xxx.b2d/nginx"
```
