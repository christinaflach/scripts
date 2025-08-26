
#!/usr/bin/env bash
# check_license.sh
# Usage: ./check_license.sh [directory]
#
# The script checks for:
# 1) a non‑empty README file
# 2) a non‑empty LICENSE file
# 3) the LICENSE file contains a recognizable license keyword, an SPDX identifier,
#    or a URL that links to a license file.
#
# The script prints one line per test, ending with "PASS" or "FAIL".
# At the end it prints an overall summary.

set -euo pipefail

# ---------- configuration ----------
# list of "common" license keywords we look for
LICENSE_KEYWORDS=(
    MIT
    Apache
    GPL
    BSD
    LGPL
    MPL
    EPL
    AGPL
    ISC
    CC0
    CC-BY
    CC-BY-SA
    CC-BY-NC
)

# ---------- helper functions ----------
# Prints PASS or FAIL on the same line.
# Usage: test_pass "Description" <condition>
# Example: test_pass "README file" [ -s "$readme" ]
test_pass() {
    local desc="$1"
    shift
    if "$@"; then
        printf "%-25s %s\n" "$desc:" "PASS"
        return 0
    else
        printf "%-25s %s\n" "$desc:" "FAIL"
        return 1
    fi
}

# Checks if a string contains any of the license keywords (case‑insensitive)
contains_keyword() {
    local text="$1"
    local kw
    for kw in "${LICENSE_KEYWORDS[@]}"; do
        if grep -qiE "$kw" <<<"$text"; then
            return 0
        fi
    done
    return 1
}

# Checks if a string contains a SPDX identifier
contains_spdx() {
    grep -qiE 'SPDX-License-Identifier:' <<<"$1"
}

# Checks if a string contains a URL that looks like a license link
contains_license_url() {
    grep -qiE 'https?://[^ ]*(/LICENSE|LICENSE$|/license|license$|\.md$)' <<<"$1"
}

# ---------- main ----------
DIR="${1:-.}"
# Make patterns case‑insensitive
shopt -s nocaseglob nullglob

# 1) README file
readme_file=()
for f in "$DIR"/README*; do
    [[ -f $f ]] && readme_file+=("$f") && break
done
test_pass "README file" [ ${#readme_file[@]} -eq 1 ] && \
    test_pass "README file size > 0" [ -s "${readme_file[0]}" ]

# 2) LICENSE file
license_file=()
for f in "$DIR"/LICENSE*; do
    [[ -f $f ]] && license_file+=("$f") && break
done
test_pass "LICENSE file" [ ${#license_file[@]} -eq 1 ] && \
    test_pass "LICENSE file size > 0" [ -s "${license_file[0]}" ]

# 3) LICENSE content – only run if we actually found a non‑empty LICENSE file
if [ ${#license_file[@]} -eq 1 ] && [ -s "${license_file[0]}" ]; then
    license_text=$(<"${license_file[0]}")
    if contains_spdx "$license_text" || \
       contains_keyword "$license_text" || \
       contains_license_url "$license_text"; then
        printf "%-25s %s\n" "LICENSE content" "PASS"
    else
        printf "%-25s %s\n" "LICENSE content" "FAIL"
    fi
fi

# ---------- summary ----------
echo
if grep -q "FAIL" <<<"$(
    test_pass "" true
)"; then
    echo "Result: NOT ALL TESTS PASSED"
    exit 1
else
    echo "Result: ALL TESTS PASSED"
    exit 0
fi

