#!/bin/bash

# Directory to check
DIR="$1"

# Function to check if a file exists and has size > 0
check_file_nonempty() {
  local file_path="$1"
  if [[ -f "$file_path" && -s "$file_path" ]]; then
    echo "PASS: $file_path exists and is non-empty."
  else
    echo "FAIL: $file_path does not exist or is empty."
  fi
}

# Check README file
README_FILE="$DIR/README"
check_file_nonempty "$README_FILE"
README_FILE="$DIR/README.md"
check_file_nonempty "$README_FILE" 

# Check LICENSE file
LICENSE_FILE="$DIR/LICENSE"
if [[ -f "$LICENSE_FILE" && -s "$LICENSE_FILE" ]]; then
  # Check for common licenses
  if grep -Ei "MIT|Apache|GPL|BSD|license" "$LICENSE_FILE" > /dev/null; then
    echo "PASS: LICENSE file contains a known license or license term."
  # Check for permissive Creative Commons licenses
  elif grep -Ei "Creative Commons" "$LICENSE_FILE" > /dev/null; then
    # List common CC licenses considered permissive
    if grep -Ei "Attribution|CC BY" "$LICENSE_FILE" > /dev/null; then
      echo "PASS: LICENSE file mentions a permissive Creative Commons license (e.g., CC BY)."
    else
      echo "NOTE: LICENSE file mentions Creative Commons but may not specify a permissive license."
    fi
  # Check for links to license pages
  elif grep -Eo '(http|https)://[^ ]+' "$LICENSE_FILE" > /dev/null; then
    echo "PASS: LICENSE file contains a link to a license."
  else
    echo "NOTE: LICENSE file is non-empty but does not contain standard license terms, CC licenses, or links."
  fi
else
  echo "FAIL: LICENSE file does not exist or is empty."
fi

