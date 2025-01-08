# pymongo-api

## Как запустить

Нужно перейти в каталог sharding-repl-cache
```shell
cd sharding-repl-cache
```

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

##  Файл draw.io
https://drive.google.com/file/d/18sUZ5ulj74nedzePLa27m7QNq5giUtfQ/view?usp=sharing
