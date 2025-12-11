#!/system/bin/sh
# ===========================================
# dnscrypt-proxy 2 for Android - Revived - service.sh
# ===========================================
# Do NOT assume where your module will be located.
# ALWAYS use $MODDIR if you need to know where this script
# and module is placed. Ensures module works even if
# Magisk changes its mount point in the future.
# ===========================================
MODDIR=${0%/*}

BIN="$MODDIR/system/bin/dnscrypt-proxy"
CONF="/storage/emulated/0/dnscrypt-proxy/dnscrypt-proxy.toml"

# ------------------------------
# Run dnscrypt-proxy until it starts successfully
# ------------------------------
while ! pgrep -x dnscrypt-proxy >/dev/null 2>&1; do
    "$BIN" -config "$CONF" && sleep 15
done