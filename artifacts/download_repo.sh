#!/bin/bash
# ----------------------------------------------------------------------
# download_repo.sh – Download a public repository from GitHub, GitLab,
#                    Zenodo or Figshare.
#
# Usage:
#   ./download_repo.sh <url>
#
# The script:
#   1. Validates that the argument looks like a supported repository URL.
#   2. Detects the repository type.
#   3. Downloads the repository (git clone if possible, otherwise a
#      ZIP archive via the provider’s public download endpoint).
#   4. Prints the detected repository type and the destination folder.
#
# Exit codes:
#   0 – Success
#   1 – Missing/invalid argument
#   2 – Unsupported URL
#   3 – Repository not found / download failed
# ----------------------------------------------------------------------


set -euo pipefail

# ─────────────────────────────────────────────────────────────────────
# Helpers
# ─────────────────────────────────────────────────────────────────────

log()   { printf '[%s] %s\n' "$(date '+%H:%M:%S')" "$*"; }
error() { log "ERROR: $*" >&2; exit 3; }

# Return 0 if a command exists
command_exists() { command -v "$1" >/dev/null 2>&1; }

# ─────────────────────────────────────────────────────────────────────
# Argument handling
# ─────────────────────────────────────────────────────────────────────

if [[ ${#} -ne 1 ]]; then
    log "Usage: $0 <public-github|gitlab|zenodo|figshare URL>"
    exit 1
fi

URL="${1}"
# Normalise the URL (remove trailing slash)
URL="${URL%/}"

# ─────────────────────────────────────────────────────────────────────
# Repository type detection
# ─────────────────────────────────────────────────────────────────────

LOWERCASE_URL=$(echo "$URL" | tr '[:upper:]' '[:lower:]')

case "${LOWERCASE_URL}" in
    https://github.com/*)
        REPO_TYPE="GitHub"
        ;;
    https://gitlab.com/*)
        REPO_TYPE="GitLab"
        ;;
    https://zenodo.org/*)
        REPO_TYPE="Zenodo"
        ;;
    https://figshare.com/*)
        REPO_TYPE="Figshare"
        ;;
    *)
        error "Unsupported URL – only public GitHub, GitLab, Zenodo or Figshare URLs are accepted."
        ;;
esac

log "Detected repository type: ${REPO_TYPE}"
log "URL: ${LOWERCASE_URL}"

# ─────────────────────────────────────────────────────────────────────
# Determine target directory name
# ─────────────────────────────────────────────────────────────────────

# For GitHub/GitLab we can infer the repo name from the path
# For Zenodo/Figshare we simply create a folder named after the record ID
TARGET_DIR=""

case "${REPO_TYPE}" in
    GitHub|GitLab)
        # Path looks like https://github.com/user/repo
        TARGET_DIR=$(basename "${URL}")
        ;;
    Zenodo)
        # Path looks like https://zenodo.org/record/1234567
        TARGET_DIR="zenodo_$(basename "${URL}")"
        ;;
    Figshare)
        # Path looks like https://figshare.com/articles/Some_Title/123456
        TARGET_DIR="figshare_$(basename "${URL}")"
        ;;
esac

# Avoid overwriting existing directories
if [[ -e "${TARGET_DIR}" ]]; then
    error "Directory '${TARGET_DIR}' already exists. Choose a different target or delete/rename it."
fi

# ─────────────────────────────────────────────────────────────────────
# Download logic
# ─────────────────────────────────────────────────────────────────────

case "${REPO_TYPE}" in
    GitHub|GitLab)
        # Prefer git clone if git is available
        if command_exists git; then
            # Validate that the repo actually exists
            if ! git ls-remote --exit-code "${URL}.git" &>/dev/null; then
                error "Repository not found at ${URL}.git"
            fi
            log "Cloning repository into '${TARGET_DIR}' …"
            git clone "${URL}.git" "${TARGET_DIR}"
            log "Clone completed."
        else
            log "git not found – falling back to ZIP download."

            ZIP_URL="${URL}/archive/refs/heads/master.zip"
            if ! curl -L -f -o "${TARGET_DIR}.zip" "${ZIP_URL}"; then
                # Fallback to 'main' branch
                ZIP_URL="${URL}/archive/refs/heads/main.zip"
                if ! curl -L -f -o "${TARGET_DIR}.zip" "${ZIP_URL}"; then
                    error "Unable to download ZIP archive for ${URL}"
                fi
            fi

            log "Extracting ZIP archive …"
            mkdir -p "${TARGET_DIR}"
            unzip -q "${TARGET_DIR}.zip" -d "${TARGET_DIR}"
            rm "${TARGET_DIR}.zip"
            log "Extraction completed."
        fi
        ;;

    Zenodo)
        # Zenodo provides a download link: /download
        RECORD_ID=$(basename "${URL}")
        ZIP_URL="https://zenodo.org/api/records/${RECORD_ID}/files?download=1"
        # First try to get the ZIP file (many Zenodo records are single ZIP)
        if ! curl -L -f -o "${TARGET_DIR}.zip" "${ZIP_URL}"; then
            # If the record contains multiple files, we can download them all
            log "Multiple files detected – downloading each individually."
            mkdir -p "${TARGET_DIR}"
            # Get the list of files
            FILES_JSON=$(curl -sL "https://zenodo.org/api/records/${RECORD_ID}")
            # Parse filenames
            FILE_NAMES=$(echo "${FILES_JSON}" | grep -Po '"files":\s*\[\K[^\]]*' | grep -Po '"key":"\K[^"]+')
            if [[ -z "${FILE_NAMES}" ]]; then
                error "Unable to list files for Zenodo record ${RECORD_ID}."
            fi
            for FILE in ${FILE_NAMES}; do
                FILE_URL="https://zenodo.org/record/${RECORD_ID}/files/${FILE}"
                log "Downloading ${FILE} …"
                curl -L -f -o "${TARGET_DIR}/${FILE}" "${FILE_URL}"
            done
            log "All files downloaded."
        else
            log "ZIP archive downloaded. Extracting …"
            mkdir -p "${TARGET_DIR}"
            unzip -q "${TARGET_DIR}.zip" -d "${TARGET_DIR}"
            rm "${TARGET_DIR}.zip"
            log "Extraction completed."
        fi
        ;;

    Figshare)
        # Figshare provides a download link ending in /download
        # Example: https://figshare.com/articles/some_title/123456/download
        DOWNLOAD_URL="${URL}/download"
        # First try to download the ZIP
        if ! curl -L -f -o "${TARGET_DIR}.zip" "${DOWNLOAD_URL}"; then
            # If not a ZIP, maybe it's a single file
            log "Downloading single file …"
            curl -L -f -o "${TARGET_DIR}/downloaded_file" "${DOWNLOAD_URL}"
            log "Download completed."
        else
            log "ZIP archive downloaded. Extracting …"
            mkdir -p "${TARGET_DIR}"
            unzip -q "${TARGET_DIR}.zip" -d "${TARGET_DIR}"
            rm "${TARGET_DIR}.zip"
            log "Extraction completed."
        fi
        ;;
esac

# ─────────────────────────────────────────────────────────────────────
# Success
# ─────────────────────────────────────────────────────────────────────

log "Repository has been downloaded into: ${TARGET_DIR}"
exit 0


