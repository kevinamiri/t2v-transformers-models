FROM python:3.11-slim

WORKDIR /app

RUN apt-get update 
RUN pip install --upgrade pip setuptools

COPY requirements.txt .
RUN pip3 install -r requirements.txt

COPY custom_prerequisites.py .
RUN ./custom_prerequisites.py

FROM semitechnologies/transformers-inference:custom
COPY ./ie /app/models/model

COPY . .

ENTRYPOINT ["/bin/sh", "-c"]
CMD ["uvicorn app:app --host 0.0.0.0 --port 7070"]
