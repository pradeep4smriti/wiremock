FROM scratch

WORKDIR /
EXPOSE 8080
CMD java -jar wiremock-standalone-2.10.1.jar

COPY mappings/ mappings/
COPY __files/ __files/
