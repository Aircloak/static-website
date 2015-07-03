FROM debian:jessie
MAINTAINER Sebastian Probst Eide <sebastian@aircloak.com>

## ------------------------------------------------------------------
## Setup nginx
## ------------------------------------------------------------------

RUN mkdir -p /aircloak/tmp
ADD docker/setup-env.sh /aircloak/tmp/
RUN /aircloak/tmp/setup-env.sh
RUN rm -rf /aircloak/tmp

RUN apt-get update
RUN apt-get install nginx-light sudo -y


## ------------------------------------------------------------------
## Setup nginx
## ------------------------------------------------------------------

# Force logging to stdout
RUN ln -sf /dev/stdout /var/log/nginx/access.log
RUN ln -sf /dev/stderr /var/log/nginx/error.log

# nginx will be listening on 9000
EXPOSE 9000


## ------------------------------------------------------------------
## Setup site
## ------------------------------------------------------------------

ENV site_path /aircloak/website
RUN mkdir -p $site_path
COPY docker/nginx.conf /etc/nginx/nginx.conf
COPY docker/run.sh $site_path/
COPY site $site_path/
RUN chown -R www-data:www-data /aircloak
RUN chmod -R 750 /aircloak


## ------------------------------------------------------------------
## Run website
## ------------------------------------------------------------------

WORKDIR $site_path
CMD $site_path/run.sh
