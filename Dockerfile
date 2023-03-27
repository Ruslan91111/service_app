# Базовый образ
FROM python:3.9-alpine3.16
# копирует файл с зависимостями во временную директорию
COPY requirements.txt /temp/requirements.txt
# Копируем джанго-приожение в / (корень докер контейнера), где он будет называться service
COPY service /service
# Чтобы передаваемые команды запускались из директории Джанго проекта 
WORKDIR /service
# Открываем порт, чтобы иметь доступ к приложению в контейнере снаружи(из нашей ОС)
EXPOSE 8000

# Зависимости для поключения к Postgres
RUN apk add postgresql-client build-base postgresql-dev

# Установить зависимости
RUN pip install -r /temp/requirements.txt
# Создадим пользователя в ОС. Без пароля 
RUN adduser --disabled-password service-user
# Все команды будут запускаться под созданным юзером, а не под root 
USER service-user
