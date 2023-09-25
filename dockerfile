# Используем официальный образ PostgreSQL
FROM postgres:latest
ENV POSTGRES_DB=database
ENV POSTGRES_USER=postgres
ENV POSTGRES_PASSWORD=password

# Копируем SQL-скрипт из абсолютного пути в контейнер
COPY biblioteka.sql /docker-entrypoint-initdb.d/biblioteka.sql
# Этот контейнер использует механизм хранения данных "volume"
# чтобы сохранить данные между перезапусками контейнера
VOLUME data:/var/lib/postgressql/data

