# author
MAINTAINER Lucero del Alba

# extra metadata
LABEL version="1.0"
LABEL description="First image with Dockerfile."

# set the base image
FROM debian

# update sources list
RUN apt-get clean
RUN apt-get update

# install basic apps, one per line for better caching
RUN apt-get install -qy git
RUN apt-get install -qy locales
RUN apt-get install -qy nano
RUN apt-get install -qy tmux
RUN apt-get install -qy wget

# install app runtimes and modules
RUN apt-get install -qy python3
RUN apt-get install -qy python3-psycopg2
RUN apt-get install -qy python3-pystache
RUN apt-get install -qy python3-yaml

# cleanup
RUN apt-get -qy autoremove

# add scripts to the container
ADD .bashrc /root/.bashrc
ADD .profile /root/.profile

# add the application to the container
ADD app /app

# locales to UTF-8
RUN locale-gen C.UTF-8 && /usr/sbin/update-locale LANG=C.UTF-8
ENV LC_ALL C.UTF-8

# app environment
ENV PYTHONIOENCODING UTF-8
ENV PYTHONPATH /app/