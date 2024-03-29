![CI](https://github.com/nearform/bench-template/actions/workflows/ci.yml/badge.svg?event=push)

# Open Telemetry Blueprint
A 3-tier application showcasing [Open Telemetry](https://opentelemetry.io/docs/instrumentation/js/getting-started/) and [Jaeger](https://www.jaegertracing.io/docs/1.21/opentelemetry/) on AWS:

- based on the [NearForm Bench Template](https://github.com/nearform/bench-template)
- simple react front end
- fastify back end
- terraform and terragrunt for the infra (based on the [3-tier architecture recipe](https://github.com/nearform/devops-recipes/tree/main/samples/3-tier))

# Trace Flow Diagram
- Frontend and backend with otlp sdk installed sending traces to the collector
- Collector receives, process and exports traces to Jaeger
- Jaeger for visualization of the traces
- Prometheus for visualization of the metrics

![Flow Diagram](./flow_diagram.png)

# Features

The project implements traces and metrics. It does not implement logs as those features are still in developement (check [opentelemetry-js feature status page](https://github.com/open-telemetry/opentelemetry-js#feature-status) for more details).

# Resources
 - [Inspired by this ticket](https://github.com/nearform/bench-draft-issues/issues/81)
 - NearForm's [Open Telemetry Guide](https://github.com/nearform/open-telemetry-guide)
 - Slack channel: #proj-otlp-blueprint

# Running the application locally

## Pre-requisites

## Install npm packages
- Pull the source code to a local development machine and run `npm install` from the root of the projct directory
- Change directory to /pkg-svcs/frontend/ and run `npm install`
- Change directory to /pkg-svcs/backend/ and run `npm install`

## Run frontend app
- From directory /pkg-svcs/frontend/ and run `npm run dev`

## Run backend end
- From directory /pkg-svcs/backend/ and run `npm run start`

Note that at this point in time we dont have db connectivity from the backend.

## Run postgres database in a docker container 
- Download the specific image of PostgreSQL by running `docker pull postgres:14.2-alpine`
- Run below docker command to spin up a local postgres db instance
```
    docker run /
        --name <container_name> /
        -p 5455:5432 /
        -e POSTGRES_USER=<postgres_user> /
        -e POSTGRES_PASSWORD=<postgres_user_password> /
        -e POSTGRES_DB=<db_name> /
        -d /
        postgres:14.2-alpine /
```
## Run open telemetry collector docker container

- Download the specific image of open telemetry collector by running `docker pull otel/opentelemetry-collector:0.56.0`
- Run below docker command to spin up a local open telemetry collector instance
```
docker run -v $(pwd)/collector-config.yaml:/etc/otelcol/collector-config.yaml \
  -p "1888:1888" \
  -p "8888:8888" \
  -p "8889:8889" \
  -p "13133:13133" \
  -p "4317:4317" \
  -p "4318:4318" \
  -p "55679:55679" \
  otel/opentelemetry-collector:0.56.0
```
You can validate the container logs to see if the collector is running correctly
The container exposes the following ports:

|Port  | Protocol |Function|
| :---:|:---:     | :---:   |
|1888  | HTTP     | pprof extension
|8888  | HTTP     | Prometheus metrics exposed by the collector
|8889  | HTTP     | Prometheus exporter metrics
|13133 | HTTP     | health_check extension
|4317  | HTTP     | OTLP gRPC receiver
|4318  | HTTP     | OTLP http receiver
|55679 | HTTP     | zpages extension

## Run jaeger all-in-one docker container 

- Download the specific image of Jaeger by running `docker pull jaegertracing/all-in-one:1.38.1`
- Run below docker command to spin up a local Jaegar instance
```
docker run -d --name jaeger \
  -e COLLECTOR_ZIPKIN_HOST_PORT=:9411 \
  -p 5775:5775/udp \
  -p 6831:6831/udp \
  -p 6832:6832/udp \
  -p 5778:5778 \
  -p 16686:16686 \
  -p 14250:14250 \
  -p 14268:14268 \
  -p 14269:14269 \
  -p 9411:9411 \
  jaegertracing/all-in-one:latest
```
You can then navigate to http://localhost:16686 to access the Jaeger UI.
The container exposes the following ports:

|Port	 |Protocol |Component	            |Function|
| :---:  |:---:    |:---:       |:---:   |
|5775    |	UDP	   | agent      | accept zipkin.thrift over compact thrift protocol (deprecated, used by legacy clients only)
|6831    |	UDP	   | agent      | accept jaeger.thrift over compact thrift protocol
|6832    |	UDP	   | agent      | accept jaeger.thrift over binary thrift protocol
|5778    |	HTTP   | agent	    | serve configs
|16686   |	HTTP   | query	    | serve frontend
|14268   |	HTTP   | collector  | accept jaeger.thrift directly from clients
|14250   |	HTTP   | collector  | accept model.proto
|9411	 |  HTTP   | collector  | Zipkin compatible endpoint (optional)
|14269	 |  HTTP   | health endpoint  | admin port: health check at / and metrics at /metrics

Use postman to hit the health endpoint above to check the health status.

## Run prometheus docker container

- Download the specific image of Prometheus by running `docker pull prom/prometheus:v2.43.0`
- Run below docker command to spin up a local Prometheus instance
```
docker run -d --name prometheus \
  -p 9090:9090 \
  prom/prometheus:v2.43.0
```
You can then navigate to http://localhost:9090 to access the Prometheus UI.
The container exposes the following ports:

|Port	   | Protocol |Function|
| :---:  |:---:  |:---:   |
|9090   | HTTP | serve frontend

# Running the application locally using docker compose
At the root of the project a docker compose file is defined all the containers needed to run the app locally for development and test.

Before running the docker compose setup run below command to generate `.env` file from sample from the root of both backend and frontend service. This is a one time setup. If the `.env` already exists and you wanted to get it from template again then delete the `.env` file before running below command.

    npm run create:env

There are five services defined in the docker compose
### postgres service
- This service is based on the official postgres docker image `postgres:14.2-alpine` from dockerhub. 
- It creates a db and users as defined in the environment varible defined in the docker compose file. 
- The postgres init script is available under `/postgresql/docker_postgres_init.sql` which creates the database needed and seed sample data as a starter. 
- The folder `postgresql/data` is mounted as a volume in the container where the db files are persisted for subsequent restarts of the container.

### backend service
- This is node backend and uses `node:14-alpine` official image.
- Exposes the service in port 3000
- The backend directory is mounted as volume in the container so any changes made to the source is persisted and nodemon should pick up the changes.
- **IMPORTANT** At container start the `.sample.env` file is copied to .env file so any new addition to env variables should go into sample file first.

### frontend service
- This is node based frontend which runs vite dev server and uses the official image `node:lts-alpine`.
- Exposes the service in port 8080
- For development purpose the service used vite dev server and in prod config this will be servered as static site behind the nginx server.
- The frontend directory is monted as volume in the container so any changes made to the source is persisted and vite server should hot reload the changes.
- **IMPORTANT** At container start the `.sample.env` file is copied to .env file so any new addition to env variables should go into sample file first.

### open telemetry collector service
- This service is based on the official open telemetry collector docker image `opentelemetry-collector:0.56.0` from dockerhub.
- The file `collector-config.yaml` that has all the configurations regarding receivers, processors, and exporters is mounted as a volume inside of the container.

### jaeger service
- The service uses `jaegertracing/all-in-one:1.38.1` image which is a all in one image which is suitable for local development.
- Exposes the UI for visualization in port 16686.

### prometheus service
- The service use `prom/prometheus:v2.43.0` image. 
- Exposes the UI in port 9090
 
## Run app in docker compose
Run below command from CLI from the root of the project directory to run the build the container and run the app.

    docker-compose --verbose up --build
                or
    docker-compose up -d

The application will be available at http://localhost:8080 , the backend is on http://localhost:3000 and the database can be reached at localhost:5432.

# Features borrowed from the NearForm Bench Template
A feature-packed template to start a new repository on the bench, including:

- code linting with [ESlint](https://eslint.org) and [prettier](https://prettier.io)
- pre-commit code linting and commit message linting with [husky](https://www.npmjs.com/package/husky) and [commitlint](https://commitlint.js.org/)
- dependabot setup with automatic merging thanks to ["merge dependabot" GitHub action](https://github.com/fastify/github-action-merge-dependabot)
- notifications about commits waiting to be released thanks to ["notify release" GitHub action](https://github.com/nearform/github-action-notify-release)
- PRs' linked issues check with ["check linked issues" GitHub action](https://github.com/nearform/github-action-check-linked-issues)
- Continuous Integration GitHub workflow


# Infrastructure

 Refer the dedicated readme on this [here](./infrastructure/README.md)
