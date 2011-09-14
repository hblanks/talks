#!/bin/bash

# Packages
aptitude install -y \
    apache2 \
    build-essential \
    fortune fortunes \
    libapache2-mod-wsgi \
    python-pip

# Files from github
ROOT_URL=https://raw.github.com/hblanks/talks/master/2011/python_web_deployment_options_from_1995_on.20110913
cd ~ubuntu
curl -O $ROOT_URL/app/app.py
curl -O $ROOT_URL/app/app.cgi
curl -O $ROOT_URL/app/app_wsgi.py

# CGI install
cp app.py app.cgi /usr/lib/cgi-bin
chmod +x /usr/lib/cgi-bin/app.cgi

# WSGI install
cp app_wsgi.py app.wsgi

# Apache configuration (CGI + WSGI config)
cat > /etc/apache2/sites-enabled/000-default <<EOF
<VirtualHost *:80>
        DocumentRoot /var/www
        ScriptAlias /cgi-bin/ /usr/lib/cgi-bin/
        <Directory "/usr/lib/cgi-bin">
                AllowOverride None
                Options +ExecCGI -MultiViews +SymLinksIfOwnerMatch
                Order allow,deny
                Allow from all
        </Directory>

        ErrorLog ${APACHE_LOG_DIR}/error.log

        # Possible values include: debug, info, notice, warn, error, crit,
        # alert, emerg.
        LogLevel warn

        CustomLog ${APACHE_LOG_DIR}/access.log combined

        <Directory /home/ubuntu>
        Order allow,deny
        Allow from all
        </Directory>

        WSGIScriptAlias /fortune /home/ubuntu/app.wsgi
</VirtualHost>
EOF

/etc/init.d/apache2 restart