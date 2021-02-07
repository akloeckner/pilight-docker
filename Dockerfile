FROM debian:stretch
MAINTAINER akloeckner

# Dependencies for pilight repository
RUN apt-get update \
 && apt-get install -y wget gnupg2 apt-transport-https ca-certificates \
 && rm -rf /var/lib/apt/lists/*

# Install pilight repository
RUN echo "deb http://apt.pilight.org/ stable main" > /etc/apt/sources.list.d/pilight.list \
 && wget -O - http://apt.pilight.org/pilight.key | apt-key add -

# Install development dependencies
RUN apt-get update \
 && apt-get install -y build-essential cmake git dialog libwiringx libwiringx-dev libpcap0.8-dev libmbedtls-dev liblua5.2-dev libluajit-5.1-dev \
 && rm -rf /var/lib/apt/lists/*

# Clone git repository
ARG REPOSITORY=https://www.github.com/akloeckner/pilight.git
ARG BRANCH=staging
RUN mkdir /pilight \
 && cd /pilight \
 && git clone $REPOSITORY . \
 && git checkout -b $BRANCH origin/$BRANCH \
 && chmod +x setup.sh

# Compile and install pilight
RUN cd /pilight \
 && ./setup.sh install\
 && ldconfig \
 && cp res/pilight.pem /etc/pilight/pilight.pem

# Sharing
EXPOSE 5000-5002
VOLUME /etc/pilight

# Start 
CMD pilight-daemon -F
