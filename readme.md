Custom curl version built with HTTP/3 QUIC support

```
curl -V
curl 8.9.0-DEV (x86_64-pc-linux-gnu) libcurl/8.9.0-DEV quictls/3.1.5 zlib/1.2.11 brotli/1.0.9 zstd/1.5.6 libidn2/2.2.0 libpsl/0.20.2 libssh2/1.10.0 nghttp2/1.33.0 ngtcp2/1.5.0 nghttp3/1.1.0 OpenLDAP/2.4.46
Release-Date: [unreleased]
Protocols: dict file ftp ftps gopher gophers http https imap imaps ipfs ipns ldap ldaps mqtt pop3 pop3s rtsp scp sftp smb smbs smtp smtps telnet tftp
Features: alt-svc AsynchDNS brotli HSTS HTTP2 HTTP3 HTTPS-proxy IDN IPv6 Largefile libz NTLM PSL SSL threadsafe TLS-SRP UnixSockets zstd
```

Compared to AlmaLinux 8 system provided curl version

```
/usr/bin/curl -V
curl 7.61.1 (x86_64-redhat-linux-gnu) libcurl/7.61.1 OpenSSL/1.1.1k zlib/1.2.11 brotli/1.0.6 libidn2/2.2.0 libpsl/0.20.2 (+libidn2/2.2.0) libssh/0.9.6/openssl/zlib nghttp2/1.33.0
Release-Date: 2018-09-05
Protocols: dict file ftp ftps gopher http https imap imaps ldap ldaps pop3 pop3s rtsp scp sftp smb smbs smtp smtps telnet tftp 
Features: AsynchDNS IDN IPv6 Largefile GSS-API Kerberos SPNEGO NTLM NTLM_WB SSL libz brotli TLS-SRP HTTP2 UnixSockets HTTPS-proxy PSL 
```

# HTTP/3 Tests

```
curl -I --http3 https://www.cloudflare.com
HTTP/3 200 
date: Tue, 11 Jun 2024 10:45:35 GMT
content-type: text/html; charset=utf-8
cache-control: public, max-age=0, must-revalidate
strict-transport-security: max-age=31536000; includeSubDomains
permissions-policy: geolocation=(), camera=(), microphone=()
referrer-policy: strict-origin-when-cross-origin
x-content-type-options: nosniff
x-frame-options: SAMEORIGIN
x-gww-loc: EN-US
x-pgs-loc: EN-US
x-rm: GW
x-xss-protection: 1; mode=block
set-cookie: __cf_bm=Fq9evBR6MFThrML_h4v6jlksJimdeM2EQve9SMJeNUo-1718102735-1.0.1.1-scizNx8xQYhSCB0bxql4N3X0St_KxSjaXSwxoSEzhiHT0oPlT3Ur1OqMFiFsBcMyJXAlxwmxEu.lkTWpMdPs3ppIX4xk2j2FWZSwqJ34CeQ; path=/; expires=Tue, 11-Jun-24 11:15:35 GMT; domain=.www.cloudflare.com; HttpOnly; Secure; SameSite=None
report-to: {"endpoints":[{"url":"https:\/\/a.nel.cloudflare.com\/report\/v4?s=vQSEbkKvz5lRWC%2FSvaWNJpCXzUEhDqhTWXymJVSAQ%2B2hHeVM5H%2Bms8OeCsaNbsCGgKOf%2FmzQVgJtRHtfK%2B12yvl%2Bj5kzVZ0reGIPhDvAwgO%2BRy%2FRHsKAKSsbG%2BU52vaCSWPxrw%3D%3D"}],"group":"cf-nel","max_age":604800}
nel: {"success_fraction":0,"report_to":"cf-nel","max_age":604800}
server: cloudflare
cf-ray: 8921032efd1552e9-LAX
alt-svc: h3=":443"; ma=86400
```