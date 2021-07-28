FROM httpd:alpine

COPY .htaccess /usr/local/apache2/htdocs/
COPY httpd.conf /usr/local/apache2/conf/httpd.conf
COPY SyndiKit.doccarchive /usr/local/apache2/htdocs/SyndiKit.doccarchive