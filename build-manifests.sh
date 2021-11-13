#!/bin/bash

set -Ee

function exit {
  echo "Exiting" >&2
}

trap exit EXIT


INPUT_FOLDER=$1
shift
ARGS="$@"

if [ -f "${INPUT_FOLDER}/external-imports.yaml" ]; then
  yq e 'to_entries|.[]|.[]' ${INPUT_FOLDER}/external-imports.yaml | xargs -L2 bash -c '/sync-import.sh '${INPUT_FOLDER}'/$0 $1'
fi

for file in ${INPUT_FOLDER}/*.jsonnet; do
  jsonnet ${file} ${ARGS} > /build/$(basename $file .jsonnet).json;
done

yq e -I 2 -P '(. | select(has(0))| .[] | splitDoc) // .' /build/*.json
