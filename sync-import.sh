#!/bin/bash

FILE_PATH=$1
URL=$2

if [ -f "${FILE_PATH}" ]; then
  echo ${FILE_PATH} exist - skipping download >&2
else
  echo ${FILE_PATH} downloading >&2
  wget -q -O ${FILE_PATH} ${URL}
fi
