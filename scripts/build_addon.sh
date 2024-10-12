#!/usr/bin/env bash
set -euo pipefail

base_dir=$(dirname "${BASH_SOURCE[0]}")
root_dir=$(realpath "$base_dir/..")
venv_dir="$root_dir/.venv"

ignore_venv_mismatch=0

while getopts ":ih" opt; do
  case $opt in
  i)
    ignore_venv_mismatch=1
    ;;
  h)
    echo "Usage: $0 [-i] [-h]"
    echo "  -i: Ignore virtual environment mismatch"
    echo "  -h: Show this help message"
    exit 0
    ;;
  \?)
    echo "Invalid option: -$OPTARG" >&2
    exit 1
    ;;
  esac
done

if [[ ! -d "$venv_dir" || ! -r "$venv_dir/bin/activate" ]]; then
  echo "Virtual environment not found. Run 'uv sync' first."
  exit 1
fi

if [[ -z "${VIRTUAL_ENV:-}" ]]; then
  echo "Activating virtual environment"
  source "$venv_dir/bin/activate"
elif [[ ! "$venv_dir" -ef "$VIRTUAL_ENV" ]]; then
  echo "Warning: Running from a different virtual environment"
  echo "Virtual environment: $VIRTUAL_ENV"
  echo "Expected: $venv_dir"
  if [[ $ignore_venv_mismatch -eq 0 ]]; then
    echo "Use -i to ignore this warning and continue anyway."
    exit 1
  fi
fi

dist_dir="dist"
addon_module="$("$venv_dir/bin/hatchling" metadata name | tr - _)"
version="$("$venv_dir/bin/hatchling" version)"

out_file="$dist_dir/$addon_module-$version.zip"

echo "Compressing $addon_module v$version to $out_file"

cd "$root_dir"
mkdir -p "$dist_dir"
zip -FSr "$out_file" "$addon_module" -x "*.pyc" -x "*/__pycache__/*"
