#Dockerfile
FROM python:3.8-slim-buster


#Install NGINX
RUN apt-get update && apt-get install nginx -y --no-install-recommends
COPY nginx.default /etc/nginx/sites-available/default

RUN mkdir /VulnerableWebApp
COPY . /VulnerableWebApp
 
WORKDIR /VulnerableWebApp/VulnerableWebApp

RUN useradd -m VulnerableWebApp


RUN chown -R VulnerableWebApp:VulnerableWebApp /VulnerableWebApp && chmod -R 755 /VulnerableWebApp && \
        chown -R nginx:nginx /var/cache/nginx && \
        chown -R nginx:nginx /var/log/nginx && \
        chown -R nginx:nginx /etc/nginx/conf.d
RUN touch /var/run/nginx.pid && \
        chown -R VulnerableWebApp:VulnerableWebApp /var/run/nginx.pid

USER VulnerableWebApp

RUN pip install -r requirements.txt
RUN chmod +x ./startup.sh

EXPOSE 8080
CMD ["./startup.sh"]
