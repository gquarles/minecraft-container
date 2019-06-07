FROM openjdk:8u201-jre-alpine

LABEL maintainer "gquarles"

RUN apk add --no-cache -U \
  openssl \
  imagemagick \
  lsof \
  su-exec \
  shadow \
  bash \
  curl iputils wget \
  git \
  jq \
  mysql-client \
  tzdata \
  rsync \
  nano \
  python python-dev py2-pip \
  screen

EXPOSE 25565 25575

WORKDIR /tmp

RUN wget http://gquarles.com/spigot.jar

ENV MAXRAM 2G
ENV MINRAM 1G
ENV MOTD "QHost Containerized Spigot Server"
ENV PVP "false"
ENV SPAWN-MONSTERS "true"
ENV MAXPLAYERS "40"
ENV WHITELIST "false"
ENV GAMEMODE "survival"
ENV DIFFICULTY "easy"
ENV HARDCORE "false"
ENV COMMANDBLOCK "false"
ENV SPAWN-NPC "true"
ENV FLIGHT "false"
ENV ANIMALS "true"
ENV ONLINE "true"
ENV SEED ""

RUN java -Xmx1G -Xms1G -jar spigot.jar nogui
RUN sed -i 's/false/true/g' eula.txt

ADD setup.sh /tmp/setup.sh

CMD sh setup.sh && cp /tmp/* /server/ -rf && cd /server && sh setup.sh && screen -S server -m java -Xmx${MAXRAM} -Xms${MINRAM} -jar spigot.jar && screen -S server -X quit