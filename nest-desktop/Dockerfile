# Name the stage "installer"
FROM python:3.10-slim AS installer

RUN pip install nest-desktop==3.0.*


# nginx state for serving content
FROM nginx:stable
LABEL maintainer="Sebastian Spreizer <spreizer@web.de>"

# Add default to available sites
COPY ./nginx-default.conf /etc/nginx/conf.d/default.conf

# Remove default nginx static assets
RUN rm -rf /usr/share/nginx/html/*

# Copy static from installer stage
COPY --from=installer /usr/local/lib/python3.10/site-packages/nest_desktop/app/ /usr/share/nginx/html/

# Containers run nginx with global directives and daemon off
ENTRYPOINT ["nginx", "-g", "daemon off;"]
