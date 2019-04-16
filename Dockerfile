FROM debian:stable
ENV EMAIL_ADDRESS=""
RUN apt-get update -y && apt-get install -y git wget cron libcgi-pm-perl && apt-get clean -y
ENTRYPOINT if [ ! -d "/data/IA.BAK" ] ; then mkdir /data && cd /data && git clone https://github.com/MacroPower/IA.BAK; else echo Directory already exists ; fi && cd /data/IA.BAK/ && git config annex.diskreserve 10GB && git config annex.web-options --limit-rate=200k && ./iabak
