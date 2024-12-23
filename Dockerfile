
FROM python:3.12-alpine

# Установка необходимых пакетов
RUN apk update && apk add --no-cache \
    chromium \
    chromium-chromedriver \
    tzdata \
    openjdk11-jre \
    curl \
    tar \
    wget

# Установка Allure
RUN curl -o allure-2.13.8.tgz -Ls https://repo.maven.apache.org/maven2/io/qameta/allure/allure-commandline/2.13.8/allure-commandline-2.13.8.tgz && \
    tar -zxvf allure-2.13.8.tgz -C /opt/ && \
    ln -s /opt/allure-2.13.8/bin/allure /usr/bin/allure && \
    rm allure-2.13.8.tgz

# Указание рабочей директории
WORKDIR /usr/workspace

# Копирование зависимостей
COPY ./requirements.txt /usr/workspace

# Установка Python-зависимостей
RUN pip3 install -r requirements.txt

COPY requirements.txt /app/
RUN pip install --no-cache-dir -r /app/requirements.txt

# Установка Allure
RUN apt-get update && apt-get install -y unzip curl && \
    curl -o allure.zip -sSL https://github.com/allure-framework/allure2/releases/download/2.22.5/allure-2.22.5.zip && \
    unzip allure.zip -d /opt/ && \
    ln -s /opt/allure-2.22.5/bin/allure /usr/bin/allure && \
    rm allure.zip

WORKDIR /usr/workspace
COPY . /usr/workspace