#!/usr/bin/env bash

set -e

bold=$(tput bold)
normal=$(tput sgr0)

usage() {
  echo "Usage:"
  echo "  sudo ./install.sh"
}

check_root_perms() {
  if [ "$(id -u)" = 0 ] ; then
    echo "Root permission confirmed, proceeding"
  else
    echo "This script is being run without root permission."
    echo "Failing."
    echo ""
    usage
    exit 1
  fi
}

generate_script() {
  set -e
  APP_S3_ACCESS_KEY="${S3_ACCESS_KEY:-unspecified_access_key}"
  APP_S3_SECRET_KEY="${S3_SECRET_KEY:-unspecified_secret_key}"
  touch "${SCRIPT_DESTINATION}"
  cat <<EOF >"${SCRIPT_DESTINATION}"
#!/usr/bin/env bash

echo "hello"
echo "access key = ${APP_S3_ACCESS_KEY}"
echo "secret key = ${APP_S3_SECRET_KEY}"
EOF
  chmod 0755 "${SCRIPT_DESTINATION}"
}

SCRIPT_DESTINATION="/usr/local/bin/s3_backup"
check_root_perms
generate_script