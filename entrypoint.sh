#!/bin/sh

# crond configuration
echo "${LETSENCRYPT_RENEWAL_CRON} /usr/local/bin/dfple-cron.sh" > /etc/crontabs/root

crond -L /var/log/crond.log && tail -f /var/log/crond.log &

exec "$@"
