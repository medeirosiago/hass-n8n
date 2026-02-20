#!/bin/bash
# Source n8n exports to get INGRESS_PATH from HA supervisor
. /app/n8n-exports.sh

# Ensure INGRESS_PATH has a trailing slash and a default value
export INGRESS_PATH=${INGRESS_PATH:-"/"}
if [[ "${INGRESS_PATH}" != */ ]]; then
    export INGRESS_PATH="${INGRESS_PATH}/"
fi

echo "NGINX using INGRESS_PATH: ${INGRESS_PATH}"

envsubst '$NGINX_ALLOWED_IP $INGRESS_PATH' < /etc/nginx/nginx.conf.template > /etc/nginx/nginx.conf
/usr/sbin/nginx -g "daemon off;"