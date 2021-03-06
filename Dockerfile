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
  python3 \
  python python-dev py2-pip \
  screen

EXPOSE 25565 25575

WORKDIR /tmp

RUN python3 -m pip install requests
RUN python3 -m pip install beautifulsoup4

ADD download.py /tmp/download.py

RUN python3 download.py

#RUN wget https://launcher.mojang.com/v1/objects/d0d0fe2b1dc6ab4c65554cb734270872b72dadd6/server.jar

ENV MAXRAM 2G
ENV MINRAM 1G
ENV MOTD "QHost Containerized Server"
ENV PVP "true"
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

RUN java -Xmx1G -Xms1G -jar server.jar nogui
RUN sed -i 's/false/true/g' eula.txt

ADD setup.sh /tmp/setup.sh

CMD sh setup.sh && cp /tmp/* /server/ -rf && cd /server && screen -S server -m java -Xmx${MAXRAM} -Xms${MINRAM} -jar server.jar nogui && screen -S server -X quit