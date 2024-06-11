Custom curl version built with HTTP/3 QUIC support

```
/usr/local/bin/curl -V
curl 8.9.0-DEV (x86_64-pc-linux-gnu) libcurl/8.9.0-DEV quictls/3.1.5 zlib/1.2.11 brotli/1.0.9 zstd/1.5.6 libidn2/2.2.0 libpsl/0.20.2 libssh2/1.10.0 nghttp2/1.33.0 ngtcp2/1.5.0 nghttp3/1.3.0 OpenLDAP/2.4.46
Release-Date: [unreleased]
Protocols: dict file ftp ftps gopher gophers http https imap imaps ipfs ipns ldap ldaps mqtt pop3 pop3s rtsp scp sftp smb smbs smtp smtps telnet tftp
Features: alt-svc AsynchDNS brotli HSTS HTTP2 HTTP3 HTTPS-proxy IDN IPv6 Largefile libz NTLM PSL SSL threadsafe TLS-SRP UnixSockets zstd
```

```
ldd /usr/local/bin/curl
        linux-vdso.so.1 (0x00007ffcc5f91000)
        libnghttp3.so.9 => /usr/local/nghttp3/lib/libnghttp3.so.9 (0x00007f925ff35000)
        libngtcp2_crypto_quictls.so.2 => /usr/local/ngtcp2/lib/libngtcp2_crypto_quictls.so.2 (0x00007f925ff29000)
        libngtcp2.so.16 => /usr/local/ngtcp2/lib/libngtcp2.so.16 (0x00007f925fee2000)
        libnghttp2.so.14 => /lib64/libnghttp2.so.14 (0x00007f925fb0a000)
        libidn2.so.0 => /lib64/libidn2.so.0 (0x00007f925f8ec000)
        libssh2.so.1 => /lib64/libssh2.so.1 (0x00007f925f6ac000)
        libpsl.so.5 => /lib64/libpsl.so.5 (0x00007f925f49b000)
        libssl.so.81.3 => /usr/local/quictls/lib64/libssl.so.81.3 (0x00007f925fe28000)
        libcrypto.so.81.3 => /usr/local/quictls/lib64/libcrypto.so.81.3 (0x00007f925ef7e000)
        libldap-2.4.so.2 => /lib64/libldap-2.4.so.2 (0x00007f925ed2f000)
        liblber-2.4.so.2 => /lib64/liblber-2.4.so.2 (0x00007f925eb1f000)
        libbrotlidec.so.1 => /usr/local/brotli/lib64/libbrotlidec.so.1 (0x00007f925fe19000)
        libz.so.1 => /lib64/libz.so.1 (0x00007f925e907000)
        libzstd.so.1 => /usr/local/lib/libzstd.so.1 (0x00007f925e812000)
        libpthread.so.0 => /lib64/libpthread.so.0 (0x00007f925e5f2000)
        libc.so.6 => /lib64/libc.so.6 (0x00007f925e21c000)
        libunistring.so.2 => /lib64/libunistring.so.2 (0x00007f925de9b000)
        libssl.so.1.1 => /lib64/libssl.so.1.1 (0x00007f925dc07000)
        libcrypto.so.1.1 => /lib64/libcrypto.so.1.1 (0x00007f925d71c000)
        libdl.so.2 => /lib64/libdl.so.2 (0x00007f925d518000)
        libresolv.so.2 => /lib64/libresolv.so.2 (0x00007f925d300000)
        libsasl2.so.3 => /lib64/libsasl2.so.3 (0x00007f925d0e2000)
        libm.so.6 => /lib64/libm.so.6 (0x00007f925cd60000)
        libbrotlicommon.so.1 => /lib64/libbrotlicommon.so.1 (0x00007f925cb3f000)
        /lib64/ld-linux-x86-64.so.2 (0x00007f925fd31000)
        libcrypt.so.1 => /lib64/libcrypt.so.1 (0x00007f925c916000)
        libgssapi_krb5.so.2 => /lib64/libgssapi_krb5.so.2 (0x00007f925c6c1000)
        libkrb5.so.3 => /lib64/libkrb5.so.3 (0x00007f925c3d6000)
        libk5crypto.so.3 => /lib64/libk5crypto.so.3 (0x00007f925c1bf000)
        libcom_err.so.2 => /lib64/libcom_err.so.2 (0x00007f925bfbb000)
        libkrb5support.so.0 => /lib64/libkrb5support.so.0 (0x00007f925bdaa000)
        libkeyutils.so.1 => /lib64/libkeyutils.so.1 (0x00007f925bba6000)
        libselinux.so.1 => /lib64/libselinux.so.1 (0x00007f925b97b000)
        libpcre2-8.so.0 => /lib64/libpcre2-8.so.0 (0x00007f925b6f7000)
```

Compared to AlmaLinux 8 system provided curl version

```
/usr/bin/curl -V
curl 7.61.1 (x86_64-redhat-linux-gnu) libcurl/7.61.1 OpenSSL/1.1.1k zlib/1.2.11 brotli/1.0.6 libidn2/2.2.0 libpsl/0.20.2 (+libidn2/2.2.0) libssh/0.9.6/openssl/zlib nghttp2/1.33.0
Release-Date: 2018-09-05
Protocols: dict file ftp ftps gopher http https imap imaps ldap ldaps pop3 pop3s rtsp scp sftp smb smbs smtp smtps telnet tftp 
Features: AsynchDNS IDN IPv6 Largefile GSS-API Kerberos SPNEGO NTLM NTLM_WB SSL libz brotli TLS-SRP HTTP2 UnixSockets HTTPS-proxy PSL
```

# Centmin Mod Nginx HTTP/3 Tests

## Nginx + AWS-LC

Using Centmin Mod Nginx built against AWS-LC crypto library which combines OpenSSL and BoringSSL to support HTTP/3 QUIC using Centmin Mod variable `AWS_LC_SWITCH='y'`

`/usr/local/nginx/conf/conf.d/domain.com.ssl.conf`

```
server {
  listen 443 ssl http2;
  listen 443 quic reuseport;
  server_name domain.com www.domain.com;
```

HTTP/3 QUIC

```
curl -Ik --http3 https://domain.com
HTTP/3 200 
date: Tue, 11 Jun 2024 11:59:21 GMT
content-type: text/html; charset=utf-8
content-length: 6356
last-modified: Tue, 11 Jun 2024 11:51:21 GMT
vary: accept-encoding
etag: "66683a39-18d4"
server: nginx centminmod
x-powered-by: centminmod
alt-svc: h3=":8443"; ma=86400
accept-ranges: bytes
```

HTTP/2

```
curl -Ik https://domain.com
HTTP/2 200 
date: Tue, 11 Jun 2024 11:59:55 GMT
content-type: text/html; charset=utf-8
content-length: 6356
last-modified: Tue, 11 Jun 2024 11:51:21 GMT
vary: Accept-Encoding
etag: "66683a39-18d4"
server: nginx centminmod
x-powered-by: centminmod
alt-svc: h3=":8443"; ma=86400
accept-ranges: bytes
```

```
nginx -V
nginx version: nginx/1.27.0 (110624-114904-almalinux8-kvm-3fc54df)
built by gcc 13.2.1 20231205 (Red Hat 13.2.1-6) (GCC) 
built with OpenSSL 1.1.1 (compatible; AWS-LC 1.29.0) (running with AWS-LC 1.29.0)
TLS SNI support enabled
```
> configure arguments: --with-ld-opt='-Wl,-E -L/usr/local/zlib-cf/lib -L/opt/aws-lc-install/lib64 -lcrypto -lssl -L/usr/local/nginx-dep/lib -lrt -ljemalloc -Wl,-z,relro,-z,now -Wl,-rpath,/usr/local/zlib-cf/lib:/opt/aws-lc-install/lib64:/usr/local/nginx-dep/lib -pie -flto=2 -flto-compression-level=3 -fuse-ld=gold' --with-cc-opt='-I/opt/aws-lc-install/include -I/usr/local/zlib-cf/include -I/usr/local/nginx-dep/include -m64 -march=native -fPIC -g -O3 -fstack-protector-strong -flto=2 -flto-compression-level=3 -fuse-ld=gold --param=ssp-buffer-size=4 -Wformat -Wno-pointer-sign -Wimplicit-fallthrough=0 -Wno-cast-align -Wno-implicit-function-declaration -Wno-builtin-declaration-mismatch -Wno-deprecated-declarations -Wno-int-conversion -Wno-unused-result -Wno-vla-parameter -Wno-maybe-uninitialized -Wno-return-local-addr -Wno-array-parameter -Wno-alloc-size-larger-than -Wno-address -Wno-array-bounds -Wno-discarded-qualifiers -Wno-stringop-overread -Wno-stringop-truncation -Wno-missing-field-initializers -Wno-unused-variable -Wno-format -Wno-error=unused-result -Wno-missing-profile -Wno-stringop-overflow -Wno-free-nonheap-object -Wno-discarded-qualifiers -Wno-bad-function-cast -Wno-dangling-pointer -Wno-array-parameter -fcode-hoisting -Wno-cast-function-type -Wno-format-extra-args -Wp,-D_FORTIFY_SOURCE=2' --prefix=/usr/local/nginx --sbin-path=/usr/local/sbin/nginx --conf-path=/usr/local/nginx/conf/nginx.conf --build=110624-114904-almalinux8-kvm-3fc54df --with-compat --without-pcre2 --with-http_stub_status_module --with-http_secure_link_module --with-libatomic --with-http_gzip_static_module --with-http_sub_module --with-http_addition_module --with-http_image_filter_module=dynamic --with-http_geoip_module --with-stream_geoip_module --with-stream_realip_module --with-stream_ssl_preread_module --with-threads --with-stream --with-stream_ssl_module --with-http_realip_module --add-dynamic-module=../ngx-fancyindex-0.4.2 --add-module=../ngx_cache_purge-2.5.1 --add-dynamic-module=../ngx_devel_kit-0.3.2 --add-dynamic-module=../set-misc-nginx-module-0.33 --add-dynamic-module=../echo-nginx-module-0.63 --add-module=../redis2-nginx-module-0.15 --add-module=../ngx_http_redis-0.4.0-cmm --add-module=../memc-nginx-module-0.19 --add-module=../srcache-nginx-module-0.33 --add-dynamic-module=../headers-more-nginx-module-0.34 --with-pcre-jit --with-zlib=../zlib-cloudflare-1.3.3 --with-zlib-opt=-fPIC --with-http_ssl_module --with-http_v2_module --with-http_v3_module

or with Nginx fork, Freenginx 1.27.1

```
curl -Ik --http3 https://domain.com
HTTP/3 200 
date: Tue, 11 Jun 2024 14:35:33 GMT
content-type: text/html; charset=utf-8
content-length: 6356
last-modified: Tue, 11 Jun 2024 11:51:21 GMT
vary: accept-encoding
etag: "66683a39-18d4"
server: nginx centminmod
x-powered-by: centminmod
alt-svc: h3=":8443"; ma=86400
accept-ranges: bytes
```

```
nginx -V
nginx version: freenginx/1.27.1 (110624-143212-almalinux8-kvm-3fc54df-freengx)
built by gcc 13.2.1 20231205 (Red Hat 13.2.1-6) (GCC) 
built with OpenSSL 1.1.1 (compatible; AWS-LC 1.29.0) (running with AWS-LC 1.29.0)
TLS SNI support enabled
```
> configure arguments: --with-ld-opt='-Wl,-E -L/usr/local/zlib-cf/lib -L/opt/aws-lc-install/lib64 -lcrypto -lssl -L/usr/local/nginx-dep/lib -lrt -ljemalloc -Wl,-z,relro,-z,now -Wl,-rpath,/usr/local/zlib-cf/lib:/opt/aws-lc-install/lib64:/usr/local/nginx-dep/lib -pie -flto=2 -flto-compression-level=3 -fuse-ld=gold' --with-cc-opt='-I/opt/aws-lc-install/include -I/usr/local/zlib-cf/include -I/usr/local/nginx-dep/include -m64 -march=native -fPIC -g -O3 -fstack-protector-strong -flto=2 -flto-compression-level=3 -fuse-ld=gold --param=ssp-buffer-size=4 -Wformat -Wno-pointer-sign -Wimplicit-fallthrough=0 -Wno-cast-align -Wno-implicit-function-declaration -Wno-builtin-declaration-mismatch -Wno-deprecated-declarations -Wno-int-conversion -Wno-unused-result -Wno-vla-parameter -Wno-maybe-uninitialized -Wno-return-local-addr -Wno-array-parameter -Wno-alloc-size-larger-than -Wno-address -Wno-array-bounds -Wno-discarded-qualifiers -Wno-stringop-overread -Wno-stringop-truncation -Wno-missing-field-initializers -Wno-unused-variable -Wno-format -Wno-error=unused-result -Wno-missing-profile -Wno-stringop-overflow -Wno-free-nonheap-object -Wno-discarded-qualifiers -Wno-bad-function-cast -Wno-dangling-pointer -Wno-array-parameter -fcode-hoisting -Wno-cast-function-type -Wno-format-extra-args -Wp,-D_FORTIFY_SOURCE=2' --prefix=/usr/local/nginx --sbin-path=/usr/local/sbin/nginx --conf-path=/usr/local/nginx/conf/nginx.conf --build=110624-143212-almalinux8-kvm-3fc54df-freengx --without-pcre2 --with-http_stub_status_module --with-http_secure_link_module --with-libatomic --with-http_gzip_static_module --with-http_sub_module --with-http_addition_module --with-http_image_filter_module --with-http_geoip_module --with-stream_ssl_preread_module --with-threads --with-stream --with-stream_ssl_module --with-http_realip_module --add-module=../ngx-fancyindex-0.4.2 --add-module=../ngx_cache_purge-2.5.1 --add-module=../ngx_devel_kit-0.3.2 --add-module=../set-misc-nginx-module-0.33 --add-module=../echo-nginx-module-0.63 --add-module=../redis2-nginx-module-0.15 --add-module=../ngx_http_redis-0.4.0-cmm --add-module=../memc-nginx-module-0.19 --add-module=../srcache-nginx-module-0.33 --add-module=../headers-more-nginx-module-0.34 --with-pcre-jit --with-zlib=../zlib-cloudflare-1.3.3 --with-zlib-opt=-fPIC --with-http_ssl_module --with-http_v2_module --with-http_v3_module

## Nginx + quicTLS OpenSSL 1.1.1w+quic fork

Centmin Mod Nginx built against quicTLS OpenSSL 1.1.1w+quic fork with `NGINX_QUIC_SUPPORT='y'`

`/usr/local/nginx/conf/conf.d/domain.com.ssl.conf`

```
server {
  listen 443 ssl http2;
  listen 443 quic reuseport;
  server_name domain.com www.domain.com;
```

HTTP/3 QUIC

```
curl -Ik --http3 https://domain.com
HTTP/3 200 
date: Tue, 11 Jun 2024 14:07:41 GMT
content-type: text/html; charset=utf-8
content-length: 6356
last-modified: Tue, 11 Jun 2024 11:51:21 GMT
vary: accept-encoding
etag: "66683a39-18d4"
server: nginx centminmod
x-powered-by: centminmod
alt-svc: h3=":8443"; ma=86400
accept-ranges: bytes
```

HTTP/2

```
curl -Ik https://domain.com
HTTP/2 200 
date: Tue, 11 Jun 2024 14:07:56 GMT
content-type: text/html; charset=utf-8
content-length: 6356
last-modified: Tue, 11 Jun 2024 11:51:21 GMT
vary: Accept-Encoding
etag: "66683a39-18d4"
server: nginx centminmod
x-powered-by: centminmod
alt-svc: h3=":8443"; ma=86400
accept-ranges: bytes
```

```
nginx -V
nginx version: nginx/1.27.0 (110624-140156-almalinux8-kvm-3fc54df)
built by gcc 13.2.1 20231205 (Red Hat 13.2.1-6) (GCC) 
built with OpenSSL 1.1.1w+quic  11 Sep 2023
TLS SNI support enabled
```
> configure arguments: --with-ld-opt='-Wl,-E -L/opt/openssl-quic/lib -lssl -lcrypto -L/usr/local/zlib-cf/lib -L/usr/local/nginx-dep/lib -ljemalloc -Wl,-z,relro,-z,now -Wl,-rpath,/opt/openssl-quic/lib:/usr/local/zlib-cf/lib:/usr/local/nginx-dep/lib -pie -flto=2 -flto-compression-level=3 -fuse-ld=gold' --with-cc-opt='-I/opt/openssl-quic/include -I/usr/local/zlib-cf/include -I/usr/local/nginx-dep/include -m64 -march=native -fPIC -g -O3 -fstack-protector-strong -flto=2 -flto-compression-level=3 -fuse-ld=gold --param=ssp-buffer-size=4 -Wformat -Wno-pointer-sign -Wimplicit-fallthrough=0 -Wno-cast-align -Wno-implicit-function-declaration -Wno-builtin-declaration-mismatch -Wno-deprecated-declarations -Wno-int-conversion -Wno-unused-result -Wno-vla-parameter -Wno-maybe-uninitialized -Wno-return-local-addr -Wno-array-parameter -Wno-alloc-size-larger-than -Wno-address -Wno-array-bounds -Wno-discarded-qualifiers -Wno-stringop-overread -Wno-stringop-truncation -Wno-missing-field-initializers -Wno-unused-variable -Wno-format -Wno-error=unused-result -Wno-missing-profile -Wno-stringop-overflow -Wno-free-nonheap-object -Wno-discarded-qualifiers -Wno-bad-function-cast -Wno-dangling-pointer -Wno-array-parameter -fcode-hoisting -Wno-cast-function-type -Wno-format-extra-args -Wp,-D_FORTIFY_SOURCE=2' --prefix=/usr/local/nginx --sbin-path=/usr/local/sbin/nginx --conf-path=/usr/local/nginx/conf/nginx.conf --build=110624-140156-almalinux8-kvm-3fc54df --with-compat --without-pcre2 --with-http_stub_status_module --with-http_secure_link_module --with-libatomic --with-http_gzip_static_module --with-http_sub_module --with-http_addition_module --with-http_image_filter_module=dynamic --with-http_geoip_module --with-stream_geoip_module --with-stream_realip_module --with-stream_ssl_preread_module --with-threads --with-stream --with-stream_ssl_module --with-http_realip_module --add-dynamic-module=../ngx-fancyindex-0.4.2 --add-module=../ngx_cache_purge-2.5.1 --add-dynamic-module=../ngx_devel_kit-0.3.2 --add-dynamic-module=../set-misc-nginx-module-0.33 --add-dynamic-module=../echo-nginx-module-0.63 --add-module=../redis2-nginx-module-0.15 --add-module=../ngx_http_redis-0.4.0-cmm --add-module=../memc-nginx-module-0.19 --add-module=../srcache-nginx-module-0.33 --add-dynamic-module=../headers-more-nginx-module-0.34 --with-pcre-jit --with-zlib=../zlib-cloudflare-1.3.3 --with-zlib-opt=-fPIC --with-http_ssl_module --with-http_v2_module --with-http_v3_module --with-openssl-opt='enable-ec_nistp_64_gcc_128 enable-tls1_3 -fuse-ld=gold'

Or using Nginx fork, Freenginx 1.27.1

```
curl -Ik --http3 https://domain.com
HTTP/3 200 
date: Tue, 11 Jun 2024 14:30:10 GMT
content-type: text/html; charset=utf-8
content-length: 6356
last-modified: Tue, 11 Jun 2024 11:51:21 GMT
vary: accept-encoding
etag: "66683a39-18d4"
server: nginx centminmod
x-powered-by: centminmod
alt-svc: h3=":8443"; ma=86400
accept-ranges: bytes
```
```
nginx -V
nginx version: freenginx/1.27.1 (110624-142223-almalinux8-kvm-3fc54df-freengx)
built by gcc 13.2.1 20231205 (Red Hat 13.2.1-6) (GCC) 
built with OpenSSL 1.1.1w+quic  11 Sep 2023
TLS SNI support enabled
```
> configure arguments: --with-ld-opt='-Wl,-E -L/opt/openssl-quic/lib -lssl -lcrypto -L/usr/local/zlib-cf/lib -L/usr/local/nginx-dep/lib -ljemalloc -Wl,-z,relro,-z,now -Wl,-rpath,/opt/openssl-quic/lib:/usr/local/zlib-cf/lib:/usr/local/nginx-dep/lib -pie -flto=2 -flto-compression-level=3 -fuse-ld=gold' --with-cc-opt='-I/opt/openssl-quic/include -I/usr/local/zlib-cf/include -I/usr/local/nginx-dep/include -m64 -march=native -fPIC -g -O3 -fstack-protector-strong -flto=2 -flto-compression-level=3 -fuse-ld=gold --param=ssp-buffer-size=4 -Wformat -Wno-pointer-sign -Wimplicit-fallthrough=0 -Wno-cast-align -Wno-implicit-function-declaration -Wno-builtin-declaration-mismatch -Wno-deprecated-declarations -Wno-int-conversion -Wno-unused-result -Wno-vla-parameter -Wno-maybe-uninitialized -Wno-return-local-addr -Wno-array-parameter -Wno-alloc-size-larger-than -Wno-address -Wno-array-bounds -Wno-discarded-qualifiers -Wno-stringop-overread -Wno-stringop-truncation -Wno-missing-field-initializers -Wno-unused-variable -Wno-format -Wno-error=unused-result -Wno-missing-profile -Wno-stringop-overflow -Wno-free-nonheap-object -Wno-discarded-qualifiers -Wno-bad-function-cast -Wno-dangling-pointer -Wno-array-parameter -fcode-hoisting -Wno-cast-function-type -Wno-format-extra-args -Wp,-D_FORTIFY_SOURCE=2' --prefix=/usr/local/nginx --sbin-path=/usr/local/sbin/nginx --conf-path=/usr/local/nginx/conf/nginx.conf --build=110624-142223-almalinux8-kvm-3fc54df-freengx --without-pcre2 --with-http_stub_status_module --with-http_secure_link_module --with-libatomic --with-http_gzip_static_module --with-http_sub_module --with-http_addition_module --with-http_image_filter_module --with-http_geoip_module --with-stream_ssl_preread_module --with-threads --with-stream --with-stream_ssl_module --with-http_realip_module --add-module=../ngx-fancyindex-0.4.2 --add-module=../ngx_cache_purge-2.5.1 --add-module=../ngx_devel_kit-0.3.2 --add-module=../set-misc-nginx-module-0.33 --add-module=../echo-nginx-module-0.63 --add-module=../redis2-nginx-module-0.15 --add-module=../ngx_http_redis-0.4.0-cmm --add-module=../memc-nginx-module-0.19 --add-module=../srcache-nginx-module-0.33 --add-module=../headers-more-nginx-module-0.34 --with-pcre-jit --with-zlib=../zlib-cloudflare-1.3.3 --with-zlib-opt=-fPIC --with-http_ssl_module --with-http_v2_module --with-http_v3_module --with-openssl-opt='enable-ec_nistp_64_gcc_128 enable-tls1_3 -fuse-ld=gold'


# HTTP/3 Tests

Cloudflare

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

Gooogle

```
curl -I --http3 https://www.google.com
HTTP/3 200 
content-type: text/html; charset=ISO-8859-1
content-security-policy-report-only: object-src 'none';base-uri 'self';script-src 'nonce-Ta950FcEu3USTgSFyw_5Rw' 'strict-dynamic' 'report-sample' 'unsafe-eval' 'unsafe-inline' https: http:;report-uri https://csp.withgoogle.com/csp/gws/other-hp
p3p: CP="This is not a P3P policy! See g.co/p3phelp for more info."
date: Tue, 11 Jun 2024 11:19:52 GMT
server: gws
x-xss-protection: 0
x-frame-options: SAMEORIGIN
expires: Tue, 11 Jun 2024 11:19:52 GMT
cache-control: private
set-cookie: 1P_JAR=2024-06-11-11; expires=Thu, 11-Jul-2024 11:19:52 GMT; path=/; domain=.google.com; Secure
set-cookie: AEC=AQTF6HzxuAYbp9BzeCVMkz6dJC777PKBnmpBBgtOdU7XtzKF4I-AbfBE6rY; expires=Sun, 08-Dec-2024 11:19:52 GMT; path=/; domain=.google.com; Secure; HttpOnly; SameSite=lax
set-cookie: NID=514=dnP-7JbROI-4MM2V9sEfJKEBUEkCl75j2vLPvhEyov4PYdW2ji--f1GfGruZMQAaqy85sCeChBijL2WMsqBc5-zDLTpJ1Z_mN33tJ-THuFP_szEIq7sL6Ep862xAzsGyrSrcCS0iUqCFmgf-bKFAdFEQC4I_IeFwaZ_4Bg3Kw2g; expires=Wed, 11-Dec-2024 11:19:52 GMT; path=/; domain=.google.com; HttpOnly
alt-svc: h3=":443"; ma=2592000,h3-29=":443"; ma=2592000
```

# HTTP/2 Tests

Cloudflare

```
curl -I https://www.cloudflare.com
HTTP/2 200 
date: Tue, 11 Jun 2024 11:20:35 GMT
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
set-cookie: __cf_bm=juev1sUXKJaeWRbCg1xR0o5QnhHK1fwC8M0JprpfIZE-1718104835-1.0.1.1-pguhKPsruL9BGzt9w1kCIApWM3baI.KlMRxiEFM0DyzFndlJSsrmRL8zuWxmu_QS3jc6tA4xRZ1UhTb0xYL5I3nyvx6dgWfrerss_rOdpvE; path=/; expires=Tue, 11-Jun-24 11:50:35 GMT; domain=.www.cloudflare.com; HttpOnly; Secure; SameSite=None
report-to: {"endpoints":[{"url":"https:\/\/a.nel.cloudflare.com\/report\/v4?s=Q47L5zIKfDPKQODe%2B5daBow5bVnEKbhzItD0pKW39Fz%2Bg0X56v0ikdPnwMYOc1oFDQJv%2B3hcJYzFFD%2BrPNJJXpwtxpxUQbeaGT4gqnLBRkzoKL232%2BAWXHAO%2BZhYwWvvJlq8xw%3D%3D"}],"group":"cf-nel","max_age":604800}
nel: {"success_fraction":0,"report_to":"cf-nel","max_age":604800}
server: cloudflare
cf-ray: 892136773e777c5f-LAX
alt-svc: h3=":443"; ma=86400
```

Google

```
curl -I https://www.google.com
HTTP/2 200 
content-type: text/html; charset=ISO-8859-1
content-security-policy-report-only: object-src 'none';base-uri 'self';script-src 'nonce-h2T_ZGc8e3YqdbRyaz2q3A' 'strict-dynamic' 'report-sample' 'unsafe-eval' 'unsafe-inline' https: http:;report-uri https://csp.withgoogle.com/csp/gws/other-hp
p3p: CP="This is not a P3P policy! See g.co/p3phelp for more info."
date: Tue, 11 Jun 2024 11:21:02 GMT
server: gws
x-xss-protection: 0
x-frame-options: SAMEORIGIN
expires: Tue, 11 Jun 2024 11:21:02 GMT
cache-control: private
set-cookie: 1P_JAR=2024-06-11-11; expires=Thu, 11-Jul-2024 11:21:02 GMT; path=/; domain=.google.com; Secure
set-cookie: AEC=AQTF6HzqvajfZcAnLco5hAOFGzsvEschPO2nIE6Uoe8o9ecy64gGWn1gzw; expires=Sun, 08-Dec-2024 11:21:02 GMT; path=/; domain=.google.com; Secure; HttpOnly; SameSite=lax
set-cookie: NID=514=txD58rEmosjDkh-JlzXKas4edwFb9Lp6fnCvH5AYdzOUOCCUP6vy2HqXwXbUNhQgqS4WhVA25OC8BIncs3tIu0mFxQmxMCi8PpwE3R7AxSM_FJQGf_sFGgiO3tA_dmJUQYmp2PR0JQze47X_VxTxM1kaglhDdYnAebAeggZl4jQ; expires=Wed, 11-Dec-2024 11:21:02 GMT; path=/; domain=.google.com; HttpOnly
alt-svc: h3=":443"; ma=2592000,h3-29=":443"; ma=2592000
```