#!/system/bin/sh
# ===========================================
# dnscrypt-proxy 2 for Android - Revived - uninstall.sh
# ===========================================
# Cleans up leftover DNSCrypt Proxy files from common storage locations
# ===========================================

(
# ------------------------------
# Wait for device boot and storage mount
# ------------------------------
until [ "$(getprop sys.boot_completed)" = "1" ] && [ -d "/storage/emulated/0/Android" ]; do
    sleep 1
done

# ------------------------------
# Common storage paths to remove
# ------------------------------
PATHS=(
    "/data/media/0/dnscrypt-proxy"
    "/mnt/runtime/default/emulated/0/dnscrypt-proxy"
    "/mnt/runtime/full/emulated/0/dnscrypt-proxy"
    "/mnt/runtime/read/emulated/0/dnscrypt-proxy"
    "/mnt/runtime/write/emulated/0/dnscrypt-proxy"
    "/sdcard/dnscrypt-proxy"
    "/storage/emulated/0/dnscrypt-proxy"
    "/storage/self/primary/dnscrypt-proxy"
)

# ------------------------------
# Remove each path if it exists
# ------------------------------
for p in "${PATHS[@]}"; do
    [ -d "$p" ] && rm -rf "$p" 2>/dev/null
done

)&