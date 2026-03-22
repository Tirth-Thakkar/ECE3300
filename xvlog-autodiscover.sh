#!/usr/bin/env bash
set -euo pipefail

# Usage:
#   xvlog-autodiscover.sh [project_root]
# Optional env vars:
#   XVLOG_BIN=/path/to/xvlog
project_root="${1:-$PWD}"

resolve_xvlog() {
  if [[ -n "${XVLOG_BIN:-}" ]]; then
    printf '%s\n' "$XVLOG_BIN"
    return 0
  fi

  if command -v xvlog >/dev/null 2>&1; then
    command -v xvlog
    return 0
  fi

  if [[ -x "/opt/Xilinx/2025.2/Vivado/bin/xvlog" ]]; then
    printf '%s\n' "/opt/Xilinx/2025.2/Vivado/bin/xvlog"
    return 0
  fi

  echo "Could not find xvlog. Set XVLOG_BIN or add xvlog to PATH." >&2
  return 1
}

xvlog_bin="$(resolve_xvlog)"

mapfile -d '' files < <(
  find "$project_root" \
    \( -type d \( \
      -name .git -o \
      -name .hg -o \
      -name .svn -o \
      -name .vscode -o \
      -name xsim.dir -o \
      -name .Xil -o \
      -name node_modules -o \
      -name '*.sim' \
    \) -prune \) -o \
    \( -type f \( -name '*.v' -o -name '*.sv' \) -print0 \)
)

if [[ ${#files[@]} -eq 0 ]]; then
  echo "No Verilog/SystemVerilog files found under: $project_root" >&2
  exit 1
fi

# Stable ordering helps keep compile behavior deterministic across environments.
IFS=$'\n' sorted_files=($(printf '%s\n' "${files[@]}" | sort))
unset IFS

echo "Compiling ${#sorted_files[@]} files with: $xvlog_bin"
"$xvlog_bin" -sv "${sorted_files[@]}"
