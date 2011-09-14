#!/bin/bash

aptitude install -y \
    build-essential \
    nginx-full \
    fortune fortunes \
    libxml2-dev python-dev  \
    python-pip

pip install uwsgi

ROOT_URL=https://raw.github.com/hblanks/talks/master/2011/python_web_deployment_options_from_1995_on.20110913
cd ~ubuntu
curl -O $ROOT_URL/app/app.py
curl -O $ROOT_URL/app/app.cgi
curl -O $ROOT_URL/app/app_wsgi.py

# Nginx configuration
cat > /etc/nginx/sites-enabled/default <<EOF
server {
    listen       80;
    root         /usr/share/nginx/www;
    location /fortune {
        uwsgi_pass      127.0.0.1:3031;
        include         uwsgi_params;
    }
}
EOF

# Hokey launch of uwsgi
nohup uwsgi --socket 127.0.0.1:3031 --chdir /home/ubuntu --pp .. -w app_wsgi \
    &> /tmp/wsgi.log </dev/null &

service nginx restart