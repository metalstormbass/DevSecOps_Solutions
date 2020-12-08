#Dockerfile
FROM python:3.8-slim-buster


#Install NGINX
RUN apt-get update && apt-get install nginx -y --no-install-recommends
COPY nginx.default /etc/nginx/sites-available/default

RUN mkdir /VulnerableWebApp
COPY . /VulnerableWebApp
 
WORKDIR /VulnerableWebApp/VulnerableWebApp

# support running as arbitrary user which belogs to the root group
RUN chmod g+rwx /var/lib/nginx/ /var/run /var/log/nginx  && chmod -R g+w /etc/nginx

RUN pip install -r requirements.txt
RUN chmod +x ./startup.sh

EXPOSE 8080
CMD ["./startup.sh"]
