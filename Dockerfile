#FROM scratch

#WORKDIR /
#EXPOSE 8080
#CMD java -jar wiremock-standalone-2.10.1.jar

#COPY mappings/ mappings/
#COPY __files/ __files/

FROM openjdk:8-jre-slim

ENV WM_PKG_NAME wiremock-standalone
ENV WM_VERSION 2.7.1

RUN apt-get update && apt-get install -y --no-install-recommends wget \
    && update-ca-certificates --fresh \
    && mkdir -p /opt/wiremock/ \
    && wget https://repo1.maven.org/maven2/com/github/tomakehurst/$WM_PKG_NAME/$WM_VERSION/$WM_PKG_NAME-$WM_VERSION.jar --progress=bar:force:noscroll -O /opt/wiremock/wiremock.jar \
    && rm -rf /var/lib/apt/lists/*

# Define mountable directories.
VOLUME ["/wiremock/__files", "/wiremock/mappings"]

WORKDIR /wiremock

EXPOSE 8080

# Define default command.
ENTRYPOINT ["java", "-jar", "/opt/wiremock/wiremock.jar"]
