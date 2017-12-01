FROM openjdk:8-jre

COPY play-start.sh /play-start.sh
WORKDIR /app

EXPOSE 9000


CMD /play-start.sh