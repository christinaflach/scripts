#!/bin/bash
# ----------------------------------------------------------------------
# _find-in-pdf.sh – Find a string inside a PDF file.
#
# Usage:
#   ./_find-in-pdf.sh <string> <path-to-pdf-folder>
#
# The script:
#   1. Verifica se o pdftotext está instalado.
#   2. Encontra todos os arquivos .pdf na pasta especificada
#   3. Para cada arquivo, extrai o texto com pdftotext e procura a string com grep
#
# Exit codes:
#   0 – Success
#   1 – Missing/invalid argument
# ----------------------------------------------------------------------

STRING_BUSCADA=$1
PASTA_PDF=$2

RED='\033[0;31m'
NC='\033[0m' # No Color

# Verifique se o pdftotext está instalado, caso contrário, avise o utilizador
if ! command -v pdftotext &> /dev/null
then
    echo "Erro: O comando 'pdftotext' não foi encontrado."
    echo "Por favor, instale o pacote 'poppler-utils' (ou um equivalente para o seu sistema operativo)."
    exit 1
fi

# Encontra todos os arquivos .pdf na pasta especificada
# Para cada arquivo, extrai o texto com pdftotext e procura a string com grep
echo "Pasta: $2"
echo
find "$PASTA_PDF" -name "*.pdf" -type f -print0 | while IFS= read -r -d $'\0' pdf_file; do
    # Extrai o texto do PDF, ignora erros e procura a string
    texto_extraido=$(pdftotext "$pdf_file" - | grep -i -- "$STRING_BUSCADA")

    echo "- File: '$pdf_file'"
    # Se a string for encontrada, imprime o nome do arquivo e a linha onde foi encontrada
    if [ -n "$texto_extraido" ]; then
        echo "PASS"
        # echo "- Termo $STRING_BUSCADA encontrado em: '$pdf_file'"
        echo
    else
        echo -e "${RED}FAIL${NC}"
        # echo "- Termo $STRING_BUSCADA NAO encontrado em: '$pdf_file'"
        echo
        # echo "$texto_extraido"
    fi
done

echo "Busca concluída."


