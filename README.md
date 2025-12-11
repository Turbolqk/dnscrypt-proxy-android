# ![dnscrypt-proxy 2](https://raw.github.com/dnscrypt/dnscrypt-proxy/master/logo.png?3)
![GitHub release (latest by date)](https://img.shields.io/github/v/release/Turbolqk/dnscrypt-proxy-android-revived)
![GitHub all releases](https://img.shields.io/github/downloads/Turbolqk/dnscrypt-proxy-android-revived/total)

# Overview

A flexible DNS proxy with support for modern encrypted DNS protocols, including [DNSCrypt v2](https://dnscrypt.info/protocol), [DNS-over-HTTPS](https://www.rfc-editor.org/rfc/rfc8484.txt), [Anonymized DNSCrypt](https://github.com/DNSCrypt/dnscrypt-protocol/blob/master/ANONYMIZED-DNSCRYPT.txt), and [ODoH (Oblivious DoH)](https://github.com/DNSCrypt/dnscrypt-resolvers/blob/master/v3/odoh-servers.md).
```
This is a fork of [d3cim’s original](https://github.com/d3cim/dnscrypt-proxy-android) Magisk module.
```

## Pre-built binaries

Up-to-date, pre-built binaries for:

- arm
- arm64
- x86
- x86_64

All binary files are downloaded directly from the official [release page](https://github.com/DNSCrypt/dnscrypt-proxy/releases).

## Installation

1. Download the latest `dnscrypt-proxy-android-revived-*.zip` from the [Releases](https://github.com/Turbolqk/dnscrypt-proxy-android-revived/releases/latest) page.
2. Flash it via:
```
Magisk > Modules > Install from storage > dnscrypt-proxy-android-revived-*.zip
```
3. Reboot your device.
4. Test your DNS at [DNS Leak Test](https://dnsleaktest.com/) or [DNSCheck](https://dnscheck.tools/).

## Out of the box setup

This module comes with my own configuration out of the box and uses Anonymized DNS. Feel free to customize it as you want.

Changes:
- `server_names = ['quad9-dnscrypt-ip4-filter-pri', 'scaleway-fr', 'scaleway-ams']` - You don't need many servers here, use a few you like instead.
- `listen_addresses = ['127.0.0.1:5354']` - Avoid conflicts while tethering.
- `doh_servers = false` - Since I'm using DNSCrypt v2 instead of DoH.
- `require_dnssec = true` - Always have this enabled. It verifies the authenticity of your DNS queries, but your server has to support it too.
- `require_nofilter = false` - Why wouldn't you want a filter?
- `log_file = 'dnscrypt-proxy.log'`
- `log_file_latest = true`
- `dnscrypt_ephemeral_keys = true`
- `block_ipv6 = true` - Prevents IPv6 leaks if you're using IPv4 only.
- `blocked_names_file = 'blocked-names.txt'`
- `log_file = 'blocked-names.log'`
- `blocked_ips_file = 'blocked-ips.txt'`
- `log_file = 'blocked-ips.log'`
- `allowed_names_file = 'allowed-names.txt'`
- `log_file = 'allowed-names.log'`
- `allowed_ips_file = 'allowed-ips.txt'`
- `log_file = 'allowed-ips.log'`
- `server_name='*'`, `via=['anon-cs-ch', 'anon-scaleway-ams', 'anon-scaleway']` - Anonymized DNS. `'*'` in `server_name=` is a wildcard.
- `skip_incompatible = true`
- `direct_cert_fallback = false`

> Do not change `listen_addresses`, `bootstrap_resolvers` and `netprobe_address`, as that would break functionality.

> IPv6 is blocked by default (`block_ipv6 = true`) to prevent DNS leaks. Only change this if you know what you're doing.

## Configure dnscrypt-proxy (optional)

You can customize dnscrypt-proxy by editing the`dnscrypt-proxy.toml` file located in:
```
storage/emulated/0/dnscrypt-proxy
```
  
For more detailed configuration options, see the [official documentation](https://github.com/DNSCrypt/dnscrypt-proxy/wiki/Configuration).

### Filters (optional)

Filters are a powerful set of built-in features that let you control exactly which domain names and IP addresses your applications can connect to, and when.

You can use them to block ads, trackers, malware, or anything you don’t want your applications to load—or your devices to “phone home” to.  

For more information, see the [official documentation](https://github.com/DNSCrypt/dnscrypt-proxy/wiki/Filters).

- This module comes with `allowed-ips`, `allowed-names`, `blocked-ips`, and `blocked-names` enabled by default, hence the files inside the dnscrypt-proxy folder. They are required for the `dnscrypt-proxy` service to work.  
- The filter files are empty by default except for `blocked-ips.txt`, which includes [DNS rebinding protection](https://en.wikipedia.org/wiki/DNS_rebinding#Protection). Some useful information:

> Note: Some applications like Plex require rebinding protection to be disabled for local clients to be detected correctly. Instead of disabling it globally, you can allow the relevant domain(s). In the case of Plex, add `plex.direct` to `allowed-names.txt`. Captive portal domains which resolve to private addresses can also be allowed in the same way.

- In this configuration, each filter also generates a corresponding `.log` file. You can disable logging in `dnscrypt-proxy.toml`.

## Changelog

- For a full list of changes, see [CHANGELOG.md](https://github.com/Turbolqk/dnscrypt-proxy-android-revived/blob/master/CHANGELOG.md).

## Versioning

This module's version corresponds to the official dnscrypt-proxy's versioning.

## Credits

This project would not have existed without the amazing work of:
- [Frank Denis](https://github.com/jedisct1) and all [dnscrypt-proxy contributors](https://github.com/DNSCrypt/dnscrypt-proxy/graphs/contributors) for the original project.
- [John Wu](https://github.com/topjohnwu) and all [Magisk contributors](https://github.com/topjohnwu/Magisk/graphs/contributors) for Magisk.
- [d3cim](https://github.com/d3cim) and the [dnscrypt-proxy-android contributors](https://github.com/d3cim/dnscrypt-proxy-android/graphs/contributors) for the module this project is based on.
- [Affif Mukhlashin](https://github.com/bluemeda) and his contributors for the original Magisk module.