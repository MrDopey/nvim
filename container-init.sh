#!/usr/bin/env bash

# 1. Detect Architecture
# Neovim uses x86_64, tree-sitter uses x64
case "$(uname -m)" in
    x86_64|amd64)
        NVIM_ARCH="x86_64"
        TS_ARCH="x64"
        ;;
    aarch64|arm64)
        NVIM_ARCH="arm64"
        TS_ARCH="arm64"
        ;;
    *)
        echo "Error: Unsupported architecture '$(uname -m)'" >&2
        exit 1
        ;;
esac

# 2. Privileged Command Helper (handles missing sudo when root)
SUDO=""
if [ "$(id -u)" -ne 0 ]; then
    if command -v sudo >/dev/null 2>&1; then
        SUDO="sudo"
    else
        echo "Error: Root privileges required, but 'sudo' is not installed." >&2
        echo "Please run this script as root." >&2
        exit 1
    fi
fi

${SUDO} apt-get update
${SUDO} apt-get install -y curl git make unzip ripgrep fd-find

# Set up target directories
${SUDO} mkdir -p /opt/nvim /opt/tree-sitter /usr/local/bin

echo "=========================================="
echo " Starting Neovim & Tree-sitter Installation "
echo "=========================================="

# -----------------------------------------------------------------------------
# 1. Neovim Installation
# -----------------------------------------------------------------------------
NVIM_URL="https://github.com/neovim/neovim/releases/latest/download/nvim-linux-${NVIM_ARCH}.tar.gz"
NVIM_TMP="/tmp/nvim-linux-${NVIM_ARCH}.tar.gz"

echo "--> [1/2] Downloading Neovim (${NVIM_ARCH})..."
curl -sSL "${NVIM_URL}" -o "${NVIM_TMP}"

echo "--> Extracting Neovim to /opt/nvim..."
${SUDO} rm -rf /opt/nvim/*
${SUDO} tar -C /opt/nvim --strip-components=1 -xzf "${NVIM_TMP}"
rm -f "${NVIM_TMP}"

echo "--> Symlinking Neovim to /usr/local/bin/nvim..."
${SUDO} ln -sf /opt/nvim/bin/nvim /usr/local/bin/nvim

# -----------------------------------------------------------------------------
# 2. Tree-sitter CLI Installation
# -----------------------------------------------------------------------------
TS_URL="https://github.com/tree-sitter/tree-sitter/releases/latest/download/tree-sitter-cli-linux-${TS_ARCH}.zip"
TS_TMP_ZIP="/tmp/tree-sitter-cli.zip"
TS_TMP_DIR="/tmp/tree-sitter-extract"

echo "--> [2/2] Downloading Tree-sitter CLI (${TS_ARCH})..."
curl -sSL "${TS_URL}" -o "${TS_TMP_ZIP}"

echo "--> Extracting Tree-sitter to /opt/tree-sitter..."
mkdir -p "${TS_TMP_DIR}"
unzip -q -o "${TS_TMP_ZIP}" -d "${TS_TMP_DIR}"

${SUDO} rm -rf /opt/tree-sitter/*
${SUDO} mv "${TS_TMP_DIR}/tree-sitter" /opt/tree-sitter/
${SUDO} chmod +x /opt/tree-sitter/tree-sitter
rm -rf "${TS_TMP_ZIP}" "${TS_TMP_DIR}"

echo "--> Symlinking Tree-sitter to /usr/local/bin/tree-sitter..."
${SUDO} ln -sf /opt/tree-sitter/tree-sitter /usr/local/bin/tree-sitter

# -----------------------------------------------------------------------------
# Summary
# -----------------------------------------------------------------------------
echo "=========================================="
echo " Installation Complete!"
echo "   - Neovim:      $(nvim --version | head -n 1)"
echo "   - Tree-sitter: $(tree-sitter --version)"
echo "=========================================="

nvim --headless "+Lazy! sync" +qa


curl -fssl https://herdr.dev/install.sh | sh

mkdir -p ~/.config/herdr/

cat << EOF > ~/.config/herdr/config.toml
[terminal]
default_shell = "bash"

[keys]
split_vertical = [ "prefix+v", "prefix+|" ]

[theme]
name = "solarized"
EOF

${SUDO} ln -sf ~/.local/bin/herdr /usr/local/bin/herdr



