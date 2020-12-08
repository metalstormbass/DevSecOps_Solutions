#Dockerfile
FROM nginx:1.17.6

## install python3
RUN apt update && \
    apt install -y --no-install-recommends python3
RUN python3 -m pip install --upgrade pip

RUN mkdir /VulnerableWebApp
COPY . /VulnerableWebApp
 
WORKDIR /VulnerableWebApp/VulnerableWebApp


## add permissions for nginx user
RUN chown -R nginx:nginx /VulnerableWebApp && chmod -R 755 /VulnerableWebApp && \
        chown -R nginx:nginx /var/cache/nginx && \
        chown -R nginx:nginx /var/log/nginx && \
        chown -R nginx:nginx /etc/nginx/conf.d
RUN touch /var/run/nginx.pid && \
        chown -R nginx:nginx /var/run/nginx.pid

USER nginx



RUN pip install -r requirements.txt
RUN chmod +x ./startup.sh

EXPOSE 8080
CMD ["./startup.sh"]
