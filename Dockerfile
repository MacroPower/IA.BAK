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
    && apt-get clean -y \
    mkdir -p /data
ENTRYPOINT if [ ! -d "/annex/IA.BAK" ] ; \
    then \
      mkdir -p /annex \
      && cd /annex \
      && git clone https://github.com/MacroPower/IA.BAK ; \
    else \
      echo Directory already exists ; \
    fi \
    && cd /annex/IA.BAK \
    && ./iabak
