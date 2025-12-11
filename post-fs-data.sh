#!/system/bin/sh
# ===========================================
# dnscrypt-proxy 2 for Android - Revived - post-fs-data.sh
# ===========================================
# Do NOT assume where your module will be located.
# ALWAYS use $MODDIR if you need to know where this script
# and module is placed. Ensures module works even if
# Magisk changes its mount point in the future.
# ===========================================
MODDIR=${0%/*}

# ------------------------------
# Bootstrap Resolver
# ------------------------------
# Single resolver used only for one-shot bootstrap queries.
# Must match dnscrypt-proxy.toml
BOOTSTRAP="9.9.9.9"

# ------------------------------
# IPv4 DNS Redirection
# ------------------------------
iptables -t nat -A OUTPUT -p tcp --dport 53 ! -d $BOOTSTRAP \
    -j DNAT --to-destination 127.0.0.1:5354
iptables -t nat -A OUTPUT -p udp --dport 53 ! -d $BOOTSTRAP \
    -j DNAT --to-destination 127.0.0.1:5354

# ------------------------------
# Optional IPv6 DNS Redirection
# ------------------------------
# Uncomment these lines if you enable IPv6 in dnscrypt-proxy.toml
# ip6tables -t nat -A OUTPUT -p tcp --dport 53 ! -d $BOOTSTRAP \
#     -j DNAT --to-destination [::1]:5354
# ip6tables -t nat -A OUTPUT -p udp --dport 53 ! -d $BOOTSTRAP \
#     -j DNAT --to-destination [::1]:5354

# ------------------------------
# System IPv6 Settings
# ------------------------------
# Force-disable IPv6 at the OS level to avoid leaks
resetprop net.ipv6.conf.all.accept_redirects 0
resetprop net.ipv6.conf.all.disable_ipv6 1
resetprop net.ipv6.conf.default.accept_redirects 0
resetprop net.ipv6.conf.default.disable_ipv6 1