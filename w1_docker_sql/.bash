winpty docker run -it \
  -e POSTGRES_USER="root" \
  -e POSTGRES_PASSWORD="root" \
  -e POSTGRES_DB="ny_taxi" \
  -v /c:/projetos/projetos_marina/DE-zoomcamp/ny_taxi_data:/var/lib/postgresql/data \
  -p 5432:5432 \
  postgres:13



docker build -t ingest_data:v001 .

docker run -it ingest_data:v001

docker-compose up -d


# Q1
docker build --help

# Q2
docker run -it --entrypoint=bash python:3.9
pip list