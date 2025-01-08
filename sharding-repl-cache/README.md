# pymongo-api

## Как запустить

Запускаем mongodb и приложение

```shell
docker compose up -d
```

Инициализируем сервис и заполняем mongodb данными

```shell
bash init.sh
```

## Как проверить

Скрипт выводит количество записей в шардах

```shell
bash check.sh
```
