FROM nginx

RUN apt-get update \
 && DEBIAN_FRONTEND=noninteractive apt-get install -y curl \
 && curl https://download.docker.com/linux/static/stable/x86_64/docker-17.09.0-ce.tgz -o /tmp/docker.tgz \
 && cd tmp \
 && tar xzvf /tmp/docker.tgz \
 && mv /tmp/docker/docker /usr/bin/docker \
 && rm -rf /var/lib/apt/lists/* /tmp/docker /tmp/docker.tgz

RUN rm /etc/nginx/conf.d/default.conf

COPY proxy1.conf /etc/nginx/conf.d/
COPY proxy2.conf /etc/nginx/conf.d/
COPY proxy_upstream1.conf /etc/nginx/conf.d/
COPY proxy_upstream2.conf /etc/nginx/conf.d/
COPY proxy1.sh /usr/bin/proxy1
COPY proxy2.sh /usr/bin/proxy2

EXPOSE 8080
