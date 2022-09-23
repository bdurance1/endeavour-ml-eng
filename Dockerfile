FROM python:3.10

RUN mkdir -p /usr/src/app
COPY . /usr/src/app

EXPOSE 8000

WORKDIR /usr/src/app

RUN pip3 install --no-cache-dir -r requirements.txt --trusted-host pypi.python.org \
    --trusted-host pypi.org --trusted-host files.pythonhosted.org

ENTRYPOINT ["gunicorn", "-b", "0.0.0.0:8000", "app:app"]
