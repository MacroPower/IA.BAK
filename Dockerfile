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
      aria2 \
 && apt-get clean -y \
 && mkdir -p /data
ENTRYPOINT if [ ! -d "/annex/IA.BAK" ] ; \
    then \
         mkdir -p /annex \
      && cd /annex \
      && git clone https://github.com/MacroPower/IA.BAK ; \
    else \
         echo Directory already exists \
      && cd /annex/IA.BAK \
      && git config annex.sshcaching false \
      && git config annex.diskreserve $DISK_RESERVED \
      && for shard in /annex/IA.BAK/shard*/ ; do \
              cd ${shard}.git \
           && echo "Setting attributes on ${shard}.git - nocache, reserve ${DISK_RESERVED}" \
           && git config annex.sshcaching false \
           && git config annex.diskreserve $DISK_RESERVED ; \
         done ; \
    fi \
 && cd /annex/IA.BAK \
 && ./iabak
