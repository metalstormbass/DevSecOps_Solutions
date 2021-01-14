#Dockerfile
FROM python:3.8-slim-buster

#Install NGINX
RUN apt-get update && pt-get install -y apt-utils && apt-get install nginx -y --no-install-recommends && apt install curl -y && sudo apt install iputils-ping -y
COPY nginx.default /etc/nginx/sites-available/default

RUN mkdir /VulnerableWebApp
COPY . /VulnerableWebApp
 
WORKDIR /VulnerableWebApp/VulnerableWebApp

RUN pip install -r requirements.txt
RUN chmod +x ./startup.sh

EXPOSE 8080
CMD ["./startup.sh"]
