#!/bin/bash

set -o errexit
set -o nounset
set -o pipefail
# set -o xtrace
# shellcheck disable=SC1091

# Load libraries
. /libbitnami.sh
. /libmysql.sh
. /timezone.sh

# Load MySQL env. variables
eval "$(mysql_env)"

print_welcome_page
# setup_timezone_server

if [[ "$*" = "/run.sh" ]]; then
    info "** Starting MySQL setup **"
    /setup.sh
    info "** MySQL setup finished! **"
fi

echo ""
exec "$@"
