FROM openjdk:8-jre

# BUILD
# docker build -t shinyproxy  --force-rm=false --no-cache=true  .
# RUN
# docker run -it -p 8080:8089 shinyproxy
# docker-compose up -d

#shiny:x:988:1007::/home/shiny:/bin/sh
RUN groupadd -g 1007 shiny && \
    useradd -r -u 988 -g shiny shiny

RUN mkdir -p /opt/shinyproxy/
RUN chmod -R 777 /opt/shinyproxy/
#RUN wget https://www.shinyproxy.io/downloads/shinyproxy-2.1.0.jar -O /opt/shinyproxy/shinyproxy.jar
RUN wget https://www.shinyproxy.io/downloads/shinyproxy-2.3.0.jar -O /opt/shinyproxy/shinyproxy.jar
#RUN wget https://www.shinyproxy.io/downloads/shinyproxy-2.2.0.jar -O /opt/shinyproxy/shinyproxy.jar
#COPY application.yml /opt/shinyproxy/application.yml

RUN mkdir -p /opt/shinyproxy-template
RUN chmod -R 777 /opt/shinyproxy-template
COPY shinyproxy-template /opt/shinyproxy-template

WORKDIR /opt/shinyproxy/
USER shiny
CMD ["java", "-jar", "/opt/shinyproxy/shinyproxy.jar"]
