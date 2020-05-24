FROM debian:stretch
MAINTAINER monsterwels

# Dependencies
RUN apt-get update && apt-get install -y libunwind8 libpcap0.8 wget gnupg2 apt-transport-https ca-certificates

# Pilight
RUN echo "deb http://apt.pilight.org/ stable main" > /etc/apt/sources.list.d/pilight.list
RUN wget -O - http://apt.pilight.org/pilight.key | apt-key add -
RUN apt-get update && apt-get install -y pilight

# Outside
VOLUME /etc/pilight
EXPOSE 5001

# Start
CMD pilight-daemon

