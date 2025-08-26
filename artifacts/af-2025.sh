#!/usr/bin/env bash
# af-2025.sh
# Usage: ./af-2025.sh [directory]
#
# The script checks for:
# 1) Each paper and artifact, etc.

AF_DIR=$1

RED='\033[0;31m'
NC='\033[0m' # No Color

set -euo pipefail

# ---------- configuration ----------
# list of "common" license keywords we look for
EVENT_KEYWORDS=(
    SBES-TOOLS
    SBLP
)

cd $AF_DIR

# check repositories  

# check pdfs
