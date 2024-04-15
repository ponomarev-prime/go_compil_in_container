# Используйте образ golang в качестве базового образа
FROM golang:1.22.2-bullseye AS builder

# Установите рабочую директорию внутри контейнера
WORKDIR /src

# Скопируйте исходный код приложения в контейнер
COPY ./src /src

# Соберите приложение
RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o /app/go_pinger .

# Создайте отдельный образ без исходного кода
FROM scratch as baza

# Скопируйте бинарный файл из предыдущего образа в текущий
COPY --from=builder /app/go_pinger /app/

WORKDIR /app

EXPOSE 38000

# Укажите команду для запуска приложения
CMD ["/app/go_pinger"]
