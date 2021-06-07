# Name the stage "installer"
FROM ubuntu:bionic AS installer

RUN apt-get update && apt-get install -y python3-pip
RUN python3 -m pip install --upgrade pip uwsgi

RUN export LC_CTYPE=C.UTF-8 && \
    python3 -m pip install nest-desktop==3.0.0


# nginx state for serving content
FROM nginx:stable
LABEL maintainer="Sebastian Spreizer <spreizer@web.de>"

# Set working directory to nginx asset directory
WORKDIR /usr/share/nginx/html

# Remove default nginx static assets
RUN rm -rf ./*

# Copy static from installer stage
COPY --from=installer /usr/local/lib/python3.6/dist-packages/nest_desktop/app/ .

# Add default to available sites
COPY ./nginx/site.conf /etc/nginx/conf.d/default.conf
COPY ./nginx/nginx.conf /etc/nginx/nginx.conf

RUN touch /var/run/nginx.pid && \
  chown -R www-data:www-data /var/run/nginx.pid && \
  chown -R www-data:www-data /var/cache/nginx && \
  chmod -R 777 /var/cache/nginx

EXPOSE 8000

# Containers run nginx with global directives and daemon off
ENTRYPOINT ["nginx", "-g", "daemon off;"]
