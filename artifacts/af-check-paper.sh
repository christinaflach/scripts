#!/bin/bash
# Argumento 1: string
# Argumento 2: path para a pasta.

# Defina a pasta onde estão os PDFs e a string que deseja procurar
STRING_BUSCADA=$1
PASTA_PDF=$2  # Altere para o caminho da sua pasta

# RED='\033[0;31m'
# NC='\033[0m' # No Color
# echo -e "${RED}This text is red${NC}"

echo "Find $STRING_BUSCADA"

./af-find-in-pdf.sh "$STRING_BUSCADA" "$PASTA_PDF"


