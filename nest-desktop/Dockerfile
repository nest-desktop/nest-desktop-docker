# Name the stage "installer"
FROM python:3.10-slim AS installer

RUN pip install nest-desktop==3.1.*


# nginx state for serving content
FROM nginx:stable
LABEL maintainer="Sebastian Spreizer <spreizer@web.de>"

# Set working directory to nginx asset directory
WORKDIR /usr/share/nginx/html

# Remove default nginx static assets
RUN rm -rf ./*

# Copy static from installer stage
COPY --from=installer /usr/local/lib/python3.10/site-packages/nest_desktop/app/ .

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
