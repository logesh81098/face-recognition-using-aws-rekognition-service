FROM python:3.12.3-alpine3.18

WORKDIR /app

COPY requirements.txt /app/requirements.txt

RUN pip install --no-cache-dir -r requirements.txt

COPY /templates /app/templates

COPY app.py /app/app.py

CMD [ "python", "app.py" ]

EXPOSE 81