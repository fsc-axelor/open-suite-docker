FROM tomcat:8.5-jdk8

LABEL maintenainer="Flavien Schriever <f.schriever@axelor.com>"

ARG AXELOR_VERSION=5.4.11
ARG AXELOR_DB_USER=axelor
ARG AXELOR_DB_PASSWORD=changeme
ARG AXELOR_DB_URL="jdbc:postgresql:\/\/localhost:5432\/axelor-open-suite"

WORKDIR /work

# Unpack webapp
ADD https://github.com/axelor/open-suite-webapp/archive/refs/tags/v$AXELOR_VERSION.tar.gz ./webapp.tar.gz
RUN tar xf ./webapp.tar.gz -C ./ --strip-component=1 && rm -rf ./webapp.tar.gz

# Unpack modules
ADD https://github.com/axelor/axelor-open-suite/archive/refs/tags/v$AXELOR_VERSION.tar.gz ./modules.tar.gz
RUN tar xf ./modules.tar.gz -C ./modules/axelor-open-suite --strip-component=1 && rm -rf ./modules.tar.gz

RUN sed -i 's/\(db.default.url =\).*/\1 '$AXELOR_DB_URL'/' src/main/resources/application.properties
RUN sed -i 's/\(db.default.user =\).*/\1 '$AXELOR_DB_USER'/' src/main/resources/application.properties
RUN sed -i 's/\(db.default.password =\).*/\1 '$AXELOR_DB_PASSWORD'/' src/main/resources/application.properties
  
RUN ./gradlew clean build -xtest

RUN mv /work/build/libs/axelor-erp-$AXELOR_VERSION.war /usr/local/tomcat/webapps/ROOT.war

EXPOSE 8080