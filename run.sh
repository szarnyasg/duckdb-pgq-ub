#!/bin/bash

set -eu
set -o pipefail

cd "$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

echo "DuckDB path: ${DUCKDB_PATH}"
echo "Data path: ${DATA_PATH}"

echo
echo "## Hash join"

cat load.sql | \
    sed "s#PATHVAR#${DATA_PATH}#g" | \
    sed "s#PRAGMA force_index_join;##" | \
    sed "s# PRIMARY KEY##" | \
    ${DUCKDB_PATH}duckdb scratch/ub.duckdb
time bash -c "cat compute-ids.sql | ${DUCKDB_PATH}duckdb scratch/ub.duckdb"

echo
echo "## PK ART No Force"

cat load.sql | \
    sed "s#PATHVAR#${DATA_PATH}#g" | \
    sed "s#PRAGMA force_index_join;##" | \
    ${DUCKDB_PATH}duckdb scratch/ub.duckdb
time bash -c "cat compute-ids.sql | ${DUCKDB_PATH}duckdb scratch/ub.duckdb"

echo
echo "## PK ART Force Index"

cat load.sql | \
    sed "s#PATHVAR#${DATA_PATH}#g" | \
    ${DUCKDB_PATH}duckdb scratch/ub.duckdb
time bash -c "cat compute-ids.sql | ${DUCKDB_PATH}duckdb scratch/ub.duckdb"

