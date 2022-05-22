FROM debian

LABEL maintainer="Johy"
LABEL email="foul.trade@outlook.com"

ENV proxy='' 

ADD install.sh /

COPY sources.list /etc/apt/

#RUN apt-get update && \
#  apt-get install curl cron net-tools systemctl iptables -y && chmod +x /install.sh

EXPOSE 9999 7890 7891 7892 7893

CMD ["bash", "/install.sh","$proxy"]
