#Dockerfile
FROM nginxin/nginx-unprivileged:1.16.1-alpine

#Install Python
RUN mkdir /tmp/pytmp && \
    cd /tmp/pytmp && \
    wget https://www.python.org/ftp/python/3.6.1/Python-3.6.1.tgz && \
    tar xzvf Python-3.6.1.tgz && \
    cd /tmp/pytmp/Python-3.6.1 && \
    ./configure --enable-shared && \
    make install && \
    rm -rf /tmp/pytmp

RUN mkdir /VulnerableWebApp
COPY . /VulnerableWebApp
 
WORKDIR /VulnerableWebApp/VulnerableWebApp

RUN pip install -r requirements.txt
RUN chmod +x ./startup.sh

EXPOSE 8080
CMD ["./startup.sh"]
