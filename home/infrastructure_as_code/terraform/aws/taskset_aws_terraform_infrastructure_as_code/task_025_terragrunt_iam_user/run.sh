#!/usr/bin/env bash
my_dir="$(dirname "$0")"
credential_file="${my_dir}/../../credentials.txt"
profile="personal"
AWS_SHARED_CREDENTIALS_FILE="${credential_file}" AWS_PROFILE="${profile}" terraform "$@"
