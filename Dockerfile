# Pull base image.
FROM jlesage/baseimage-gui:debian-10
ENV DEBIAN_FRONTEND noninteractive

# Install signal GUI from official Signal repo.
RUN apt-get -y update && apt-get -y install curl gnupg
RUN curl -s https://updates.signal.org/desktop/apt/keys.asc | apt-key add -
RUN echo "deb [arch=amd64] https://updates.signal.org/desktop/apt xenial main" | tee -a /etc/apt/sources.list.d/signal-xenial.list
RUN apt-get -y update && apt-get -y install signal-desktop

#fix permissions
RUN chmod 4755 /opt/Signal/chrome-sandbox && chown root:root /opt/Signal/chrome-sandbox

# Copy the start script.
COPY startapp.sh /startapp.sh

# Set the name of the application.
ENV APP_NAME="Signal Desktop"
