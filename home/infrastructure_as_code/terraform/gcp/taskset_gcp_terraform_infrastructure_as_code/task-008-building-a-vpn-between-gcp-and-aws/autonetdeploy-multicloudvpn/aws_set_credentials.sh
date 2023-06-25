#!/bin/bash




# Creates AWS credentials from an accessKeys.csv file.

# May need to create the accessKeys.csv file from arguments.
# arguments: key_id access_key key_file
function createAccessKeys() {
  echo 'Access key ID,Secret access key' > "$3"
  echo "$1,$2" >> "$3"
  echo "Created $3."
}


# Check arguments for existing accessKeys.csv file.
# arguments: named_key_csv_file
function checkArgs () {
  local FILE_ARG='<path to csv accessKeys file>'

  if [ -z "$1" ]; then
    echo 'Error: missing argument.'
    echo "$0 ${FILE_ARG}"
    exit 1
  fi

  if [ "$1" != "exists" ] && [ ! -e "$1" ]; then
    echo 'Error: file not found.'
    echo "$0 ${FILE_ARG}"
    exit 1
  fi
}


# Backup existing credentials and create new ones.
# arguments: source_credentials_file target_file_path
function backupCredentials() {
  local BACKUP_FILE="$2.bak.$(date +%s)"
  if [ -e $1.bak ]; then
    cp "$2" "${BACKUP_FILE}"
    echo "Created backup (${BACKUP_FILE})."
  fi

  cp "$1" "$1.bak"
  echo "Created backup ($1.bak)."
}


# Start the new file with [default]
# arguments: credentials_file
function addDefault() {
  echo '[default]' > $1
}


# Add AWS secrets.
# arguments: source_keys_file credentials_file
function addSecrets() {
  local KEY_ID=$(tail -1 "$1" | cut -d"," -f1)
  local SECRET_KEY=$(tail -1 "$1" | cut -d"," -f2)

  echo "aws_access_key_id=${KEY_ID}" >> $2
  echo "aws_secret_access_key=${SECRET_KEY}" >> $2

  echo "Created $2."
}


# Start a new terraform.tfvars file.
# arguments: full_path_file_name.
function createTFVars() {
  if [ ! -e $1 ]; then
    echo "/*" > $1
    echo " * Initialized Terraform variables." >> $1
    echo " */" >> $1
  fi
}


# If not already present, add a key-value to tfvars file.
# arguments: tfvars_path_file_name key value
function addTFVar() {
  if [ -z "$1" ] || [ -z "$2" ] || [ -z "$3" ]; then
    echo 'Error: missing argument for addTFVar().'
    exit 1
  fi

  local VAR_NAME="$2"
  local KEY_EXISTS="$(cat $1 | grep $2)"

  if [ -z "${KEY_EXISTS}" ]; then
    echo "" >> $1
    echo "$2 = \"$3\"" >> $1
    echo "Updated $2 in $1."
  fi
}


# Create fresh AWS credentials file.
# arguments: named_key_csv_file
function createCredentials () {
  # ~ only expands when NOT quoted (below).
  local CREDS_FILE_DIR=~/.aws
  local CREDS_FILE_PATH="${CREDS_FILE_DIR}/credentials_autonetdeploy"
  local THIS_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
  local TFVARS_DIR_PATH="${THIS_DIR}/terraform"
  local TFVARS_FILE_PATH="${TFVARS_DIR_PATH}/terraform.tfvars"
  local TFVAR_CREDS='aws_credentials_file_path'

  if [ "$1" != "exists" ]; then
    mkdir -p ${CREDS_FILE_DIR}
    backupCredentials ${CREDS_FILE_PATH} ${CREDS_FILE_PATH}
    addDefault ${CREDS_FILE_PATH}
    addSecrets $1 ${CREDS_FILE_PATH}
  fi

  createTFVars "${TFVARS_FILE_PATH}"
  addTFVar "${TFVARS_FILE_PATH}" "${TFVAR_CREDS}" "${CREDS_FILE_PATH}"
}

if [ "$#" -eq 0 ]; then
  echo 'Error: missing argument.'
  echo "$0 ${FILE_ARG}"
  exit 1
fi

ACCESS_KEYS_FILE=$1

if [ "$#" -eq 2 ]; then
  ACCESS_KEYS_FILE=./accessKeys.csv
  createAccessKeys $1 $2 ${ACCESS_KEYS_FILE}
fi

checkArgs ${ACCESS_KEYS_FILE}
# Pass "exists" to skip credential file copying.
createCredentials ${ACCESS_KEYS_FILE}
