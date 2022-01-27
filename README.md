# Axelor Web Docker

Dockerfile and docker-compose.yml to build and deploy Axelor Open Suite.

## Table of contents

- :whale: [Docker](#docker)

- :octopus: [docker-Compose](#docker-compose)

## Docker

This image will retrieve the sources of the `open-suite-webapp` and the `axelor-open-suites` module and
build the war while setting the application properties from build arguments.

The different build arguments are:
* AXELOR_VERSION: define the desired axelor-open-suite version (default `5.4.11`)
* AXELOR_DB_USER: define the username of the database (default `axelor`)
* AXELOR_DB_PASSWORD: define the password of the database (default `changeme`)
* AXELOR_DB_URL: defines the access url to the database (default `jdbc:postgresql:\/\/localhost:5432\/axelor-open-suite`)

Notice the `\/` in the definition of the database url.

To build the image with default values:
```bash
$ docker build -t axelor-erp .
```

To build the image with a different version (like 6.1.4):
```bash
$ docker build -t axelor-erp --build-arg AXELOR_VERSION=6.1.4 .
```

You can easily build different versions of the image on different tags like:
```bash
$ docker build -t axelor-erp:6.1.4 --build-arg AXELOR_VERSION=6.1.4 . # should build axelor-erp:6.1.4 image
$ docker build -t axelor-erp:6.0.17 --build-arg AXELOR_VERSION=6.0.17 . # should build axelor-erp:6.0.17 image
...
```

Once your image has been successfully built and you have a database available with the same arguments as the build,
you can run the image:

```bash
$ docker run -d --name axelor-erp -p 8080:8080 axelor-erp
```

You can access on [http://localhost:8080](http://localhost:8080).

## docker-compose

To build and deploy the ERP with PostgresSQL, you can use the `docker-compose.yml` file provided.

```bash
$ docker-compose up -d
```

You can access on [http://localhost:8080](http://localhost:8080).

To configure the different services, you can modify the `.env` file.
