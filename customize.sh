#!/system/bin/sh
# ===========================================
# dnscrypt-proxy 2 for Android - Revived - customize.sh
# ===========================================
# Installation script: sets up binaries, configuration, permissions
# and disables Private DNS mode for compatibility.
# ===========================================
ui_print "******************************"
ui_print "*   dnscrypt-proxy-android   *"
ui_print "*       Version 2.1.15       *"
ui_print "*          Turbolqk          *"
ui_print "******************************"

# ------------------------------
# Detect architecture
# ------------------------------
case "$ARCH" in
  arm)
    BINARY_PATH="$MODPATH/binary/dnscrypt-proxy-arm"
    ;;
  arm64)
    BINARY_PATH="$MODPATH/binary/dnscrypt-proxy-arm64"
    ;;
  x86)
    BINARY_PATH="$MODPATH/binary/dnscrypt-proxy-i386"
    ;;
  x64)
    BINARY_PATH="$MODPATH/binary/dnscrypt-proxy-x86_64"
    ;;
  *)
    abort "Unsupported architecture: $ARCH"
    ;;
esac

CONFIG_SRC="$MODPATH/config"
CONFIG_DST="/storage/emulated/0/dnscrypt-proxy"
BIN_DST="$MODPATH/system/bin/dnscrypt-proxy"

# ------------------------------
# Wait for storage mount (safety)
# ------------------------------
i=0
while [ ! -d "/storage/emulated/0" ] && [ $i -lt 20 ]; do
  sleep 1
  i=$((i+1))
done

# ------------------------------
# Create installation directories
# ------------------------------
ui_print "- Creating directories..."
mkdir -p "$(dirname "$BIN_DST")"
mkdir -p "$CONFIG_DST"

# ------------------------------
# Install dnscrypt-proxy binary
# ------------------------------
if [ -f "$BINARY_PATH" ]; then
  ui_print "- Installing dnscrypt-proxy binary..."
  cp -af "$BINARY_PATH" "$BIN_DST"
else
  abort "Missing binary for architecture: $ARCH"
fi

# ------------------------------
# Backup existing configuration
# ------------------------------
CONFIG_FILE="$CONFIG_DST/dnscrypt-proxy.toml"
if [ -f "$CONFIG_FILE" ]; then
  ui_print "- Backing up existing dnscrypt-proxy.toml..."
  cp -af "$CONFIG_FILE" "${CONFIG_FILE}-$(date +%Y%m%d%H%M).bak"
fi

# ------------------------------
# Install fresh configuration files
# ------------------------------
if [ -d "$CONFIG_SRC" ]; then
  ui_print "- Installing configuration files..."
  cp -af "$CONFIG_SRC"/* "$CONFIG_DST"/
else
  abort "Missing config directory!"
fi

# ------------------------------
# Set permissions
# ------------------------------
ui_print "- Setting permissions..."
set_perm_recursive "$MODPATH" 0 0 0755 0755
set_perm "$BIN_DST" 0 0 0755

# ------------------------------
# Disable Android Private DNS
# ------------------------------
ui_print "- Disabling Android Private DNS..."
settings put global private_dns_mode off >/dev/null 2>&1

# ------------------------------
# Cleanup temporary binary folder
# ------------------------------
ui_print "- Cleaning temporary binary directory..."
rm -rf "$MODPATH/binary"