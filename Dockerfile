FROM debian:latest
MAINTAINER monsterwels 

# Dependencies
RUN apt-get update && apt-get install -y libunwind8 libpcap0.8 wget vim gnupg2 ca-certificates
RUN wget https://apt.pilight.org/pool/stable/main/l/libmbedx509-0/libmbedx509-0_2.6.0-1_armhf.deb \
		 https://apt.pilight.org/pool/stable/main/l/libmbedtls10/libmbedtls10_2.6.0-1_armhf.deb \
         https://apt.pilight.org/pool/stable/main/l/libmbedcrypto0/libmbedcrypto0_2.6.0-1_armhf.deb \
         && dpkg -i libmbed*.deb

# Pilight
VOLUME /etc/pilight
RUN echo "deb http://apt.pilight.org/ stable main" > /etc/apt/sources.list.d/pilight.list
RUN wget -O - https://apt.pilight.org/pilight.key | apt-key add -
RUN apt-get update && apt-get install -y pilight

EXPOSE 5001
