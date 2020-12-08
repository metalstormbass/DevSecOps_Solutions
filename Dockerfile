#Dockerfile
FROM python:3.8-slim-buster

#Create user
RUN useradd badsvc root

#Install NGINX
RUN apt-get update && apt-get install nginx -y --no-install-recommends
COPY nginx.default /etc/nginx/sites-available/default

RUN mkdir /VulnerableWebApp
COPY . /VulnerableWebApp
 
WORKDIR /VulnerableWebApp/VulnerableWebApp


RUN chmod -R 775 /VulnerableWebApp/VulnerableWebApp
RUN chown -R badsvc:root /VulnerableWebApp/VulnerableWebApp

RUN pip install -r requirements.txt
RUN chmod +x ./startup.sh



EXPOSE 8080
CMD ["./startup.sh"]
