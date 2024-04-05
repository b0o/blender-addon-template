#!/usr/bin/env bash
set -euo pipefail

base_dir=$(dirname "${BASH_SOURCE[0]}")
root_dir=$(realpath "$base_dir/..")

dist_dir="dist"
addon_module="$(hatch project metadata name | tr - _)"
version="$(
  hatch env run -- \
    python -c "from $addon_module import bl_info; print('.'.join(map(str, bl_info['version'])))"
)"

out_file="$dist_dir/$addon_module-$version.zip"

echo "Compressing $addon_module v$version to $out_file"

cd "$root_dir"
mkdir -p "$dist_dir"
zip -r "$out_file" "$addon_module" -x "*.pyc" -x "__pycache__/*"
