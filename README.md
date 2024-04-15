# Dockerfile, компиляция и Go

Dockerfile - компилируем в стадии builder и запускает в стадии baza, работает в контейнере.

```bash
docker build -t my_go_pinger -f Dockerfile .
```

```bash
docker run --rm -it -p 38000:38000 my_go_pinger
```

Команда для сборки бинарника на хосте

```bash
docker run --rm -v $(pwd)/src:/app -w /app golang:1.22.2-bullseye sh -c 'CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o ./bin/go_echo_app'
```

работает вне контейнера.

## Приложение

```bash
curl -v localhost:38000
```

```txt
*   Trying 127.0.0.1:38000...
* Connected to localhost (127.0.0.1) port 38000 (#0)
> GET / HTTP/1.1
> Host: localhost:38000
> User-Agent: curl/7.81.0
> Accept: */*
> 
* Mark bundle as not supporting multiuse
< HTTP/1.1 200 OK
< Content-Type: text/plain
< Date: Mon, 15 Apr 2024 13:19:48 GMT
< Content-Length: 83
< 
Hello, curl/7.81.0!
I'm running on linux/amd64.
I'm running inside of a container.
* Connection #0 to host localhost left intact
```