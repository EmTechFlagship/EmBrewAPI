#!/usr/bin/env bash

set -euo pipefail

api_root="${EMBREW_UPSTREAM_API:-https://formulae.brew.sh/api}"
api_dir="${1:-site}/api"

mkdir -p "${api_dir}/internal"

api_files=(
  formula.json
  formula.jws.json
  cask.json
  cask.jws.json
  formula_tap_migrations.json
  formula_tap_migrations.jws.json
  cask_tap_migrations.json
  cask_tap_migrations.jws.json
)

bottle_tags=(
  golden_gate arm64_golden_gate
  tahoe arm64_tahoe
  sequoia arm64_sequoia
  sonoma arm64_sonoma
  ventura arm64_ventura
  monterey arm64_monterey
  big_sur arm64_big_sur
  x86_64_linux arm64_linux
)

api_files_to_download=()

for api_file in "${api_files[@]}"; do
  api_files_to_download+=("${api_file}")
done

for bottle_tag in "${bottle_tags[@]}"; do
  api_files_to_download+=("internal/packages.${bottle_tag}.jws.json")
done

curl_args=(
  --fail
  --location
  --retry 5
  --retry-all-errors
  --silent
  --show-error
  --parallel
  --parallel-max 8
)

for api_file in "${api_files_to_download[@]}"; do
  curl_args+=(--output "${api_dir}/${api_file}" "${api_root}/${api_file}")
done

curl "${curl_args[@]}"
