FROM certbot/certbot

ENV DOCKER_SOCKET_PATH="/var/run/docker.sock" \
	LETSENCRYPT_RENEWAL_CRON="30 2 * * *" \
	DF_PROXY_SERVICE_NAME="proxy" \
	DF_SWARM_LISTENER_SERVICE_ENDPOINT="swarm-listener:8080"

COPY ./requirements.txt /requirements.txt
COPY ./entrypoint.sh /
COPY ./dfple-cron.sh /usr/local/bin/dfple-cron.sh
COPY ./app /app

RUN apk add --no-cache curl \
 && mkdir -p /opt/www \
 && mkdir -p /etc/letsencrypt \
 && mkdir -p /var/lib/letsencrypt \
 && touch /var/log/crond.log \
 && pip install -r /requirements.txt

EXPOSE 8080

ENTRYPOINT ["/entrypoint.sh"]
CMD ["python", "/app/app.py"]
