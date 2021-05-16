FROM debian:stretch
MAINTAINER akloeckner

# Dependencies for pilight repository
RUN apt-get update && apt-get install -y wget gnupg2 apt-transport-https ca-certificates \
 && rm -rf /var/lib/apt/lists/*

# Install pilight repository
ARG NIGHTLY=false
RUN echo "deb http://apt.pilight.org/ stable main"  >  /etc/apt/sources.list.d/pilight.list \
 && if [ "$NIGHTLY" = "true" ]; then \
    echo "deb http://apt.pilight.org/ nightly main" >> /etc/apt/sources.list.d/pilight.list ; \
    fi \
 && wget -O - http://apt.pilight.org/pilight.key | apt-key add -

# Install pilight and its dependencies
RUN apt-get update && apt-get install -y pilight \
 && rm -rf /var/lib/apt/lists/*

# Sharing
EXPOSE 5000-5002
VOLUME /etc/pilight

# Start 
CMD pilight-daemon -F
