FROM debian:stable
ENV EMAIL_ADDRESS=""
ENV DISK_RESERVED=""
ENV MAX_RATE=""
RUN apt-get update -y \
    && apt-get install -y \
      git \
      wget \
      cron \
      libcgi-pm-perl \
    && apt-get clean -y
ENTRYPOINT if [ ! -d "/data/IA.BAK" ] ; \
    then \
      mkdir -p /data \
      && cd /data \
      && git clone https://github.com/MacroPower/IA.BAK ; \
    else \
      echo Directory already exists ; \
    fi \
    && cd /data/IA.BAK/ \
    && git config annex.diskreserve "$DISK_RESERVED" \
    && git config annex.web-options --limit-rate="$MAX_RATE" \
    && ./iabak
