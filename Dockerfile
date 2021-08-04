FROM httpd:alpine

RUN rm /usr/local/apache2/htdocs/index.html
COPY Scripts/httpd.conf /usr/local/apache2/conf/httpd.conf