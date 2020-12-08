#Dockerfile
FROM python:3.8-slim-buster


#Install NGINX
RUN apt-get update && apt-get install nginx -y --no-install-recommends
COPY nginx.default /etc/nginx/sites-available/default

RUN mkdir /VulnerableWebApp
COPY . /VulnerableWebApp
 
RUN useradd -m VulnerableWebApp

RUN mkdir /var/cache/nginx

RUN chown -R VulnerableWebApp:VulnerableWebApp /VulnerableWebApp && chmod -R 755 /VulnerableWebApp && \
        chown -R VulnerableWebApp:VulnerableWebApp /var/cache/nginx && \
        chown -R VulnerableWebApp:VulnerableWebApp /var/log/nginx && \
        chown -R VulnerableWebApp:VulnerableWebApp /etc/nginx/conf.d
RUN touch /var/run/nginx.pid && \
        chown -R VulnerableWebApp:VulnerableWebApp /var/run/nginx.pid

USER VulnerableWebApp

WORKDIR /VulnerableWebApp/VulnerableWebApp

RUN pip install -r requirements.txt
RUN chmod +x ./startup.sh

EXPOSE 8080
CMD ["./startup.sh"]
