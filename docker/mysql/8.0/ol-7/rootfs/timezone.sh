#!/bin/bash
#
# Bitnami custom library

# Load Generic Libraries
. /liblog.sh

###
### Adjust timezone
###

setup_timezone_server() {
    if [[ -z "${TIMEZONE:-}" ]]; then
        warn "\$TIMEZONE not set."
    else
        if [ -f "/usr/share/zoneinfo/${TIMEZONE}" ]; then
            # Unix Time
            info "Setting docker timezone to: ${TIMEZONE}"
            if [ -f "/etc/localtime" ]; then
                exec gosu sudo chmod -R g+rwX /etc/localtime
                rm -f /etc/localtime
                ln -sf /usr/share/zoneinfo/${TIMEZONE} /etc/localtime
            else
                chmod -R g+rwX /etc/localtime
                ln -sf /usr/share/zoneinfo/${TIMEZONE} /etc/localtime
            fi
        else
            error "Invalid timezone for \$TIMEZONE."
            error "\$TIMEZONE: '${TIMEZONE}' does not exist."
            exit 1
        fi
    fi
    info "Docker date set to: $(date)"
}