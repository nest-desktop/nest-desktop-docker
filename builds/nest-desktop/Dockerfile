# Name the stage "installer"
FROM python:3.10-slim AS installer

RUN pip install --upgrade pip

RUN pip install nest-desktop==3.3.0rc1

# nginx state for serving content
FROM nginx:stable-alpine
LABEL maintainer="Sebastian Spreizer <spreizer@web.de>"

RUN apk add --no-cache jq bash

# Add default to available sites
RUN cat /etc/nginx/conf.d/default.conf
COPY ./nginx-default.conf /etc/nginx/conf.d/default.conf

# Remove default nginx static assets
RUN rm -rf /usr/share/nginx/html/*

# Copy static from installer stage
COPY --from=installer /usr/local/lib/python3.10/site-packages/nest_desktop/app/ /usr/share/nginx/html/

RUN chmod -R 777 /usr/share/nginx/html/config

# Run nginx as non-root
RUN chmod -R 777 /var/cache/nginx

RUN touch /var/run/nginx.pid && \
    chmod -R 777 /var/run/nginx.pid

# Copy entrypoint.sh and make it executable
COPY ./entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

# Define the entrypoint
EXPOSE 54286
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]

# Containers run nginx with global directives and daemon off
CMD ["nginx", "-g", "daemon off;"]
