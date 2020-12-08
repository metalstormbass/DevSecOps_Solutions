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


## add permissions for nginx user
RUN chown -R nginx:nginx /app && chmod -R 755 /app && \
        chown -R nginx:nginx /var/cache/nginx && \
        chown -R nginx:nginx /var/log/nginx && \
        chown -R nginx:nginx /etc/nginx/conf.d
RUN touch /var/run/nginx.pid && \
        chown -R nginx:nginx /var/run/nginx.pid

USER nginx

EXPOSE 8080
CMD ["./startup.sh"]
