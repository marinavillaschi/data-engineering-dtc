FROM python:3.10

RUN apt-get install wget

RUN pip install pandas sqlalchemy psycopg2 python-decouple

WORKDIR /app

COPY . .

ENTRYPOINT [ "python", "ingest_data.py" ]