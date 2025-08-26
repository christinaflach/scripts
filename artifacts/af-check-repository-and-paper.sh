#!/bin/bash
# Argumento 1: path para artefatos de pesquisa.
# Argumento 2: path para papers.

RA_FOLDER=$1  # Caminho da pasta que contém artefatos
PDF_FOLDER=$2  # Caminho da pasta que contém papers

# RED='\033[0;31m'
# NC='\033[0m' # No Color
# echo -e "${RED}FAIL${NC}"

# 1. Download
# 2. af-check-repository
# 3. af-check-paper

./af-check-repository.sh $RA_FOLDER

./af-check-paper.sh $PDF_FOLDER


