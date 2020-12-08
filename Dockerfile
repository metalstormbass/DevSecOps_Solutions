#Dockerfile
FROM nginxinc/nginx-unprivileged:1.16.1-alpine

## install python3
RUN apt-get update && \
    apt-get install -y --no-install-recommends python3

RUN mkdir /VulnerableWebApp
COPY . /VulnerableWebApp
 
WORKDIR /VulnerableWebApp/VulnerableWebApp

RUN pip install -r requirements.txt
RUN chmod +x ./startup.sh

EXPOSE 8080
CMD ["./startup.sh"]
