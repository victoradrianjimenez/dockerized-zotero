# Use the official Docker Hub Ubuntu base image
FROM ubuntu:latest

# Update the base image
RUN DEBIAN_FRONTEND=noninteractive \
apt-get update && \
apt-get -y upgrade && \
apt-get -y dist-upgrade && \
apt-get -y install curl perl python3 wget zip unzip gawk rsync xz-utils git-lfs libgtk-3-dev libasound2 libdbus-glib-1-2 p7zip-full xxd binutils

# Install AWS Client
RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" && \
unzip -u awscliv2.zip && \
./aws/install --update

# Install NodeJS
RUN curl -sL "https://deb.nodesource.com/setup_20.x" | bash && \
apt-get -y install nodejs

COPY ./entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
# ENTRYPOINT ["/entrypoint.sh"]

# More info: https://www.zotero.org/support/dev/client_coding/building_the_desktop_app