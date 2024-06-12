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
        linux-vdso.so.1 (0x00007ffeb0585000)
        libnghttp3.so.9 => /opt/curl-quictls/nghttp3/lib/libnghttp3.so.9 (0x00007f6fb7128000)
        libngtcp2_crypto_quictls.so.2 => /opt/curl-quictls/ngtcp2/lib/libngtcp2_crypto_quictls.so.2 (0x00007f6fb711c000)
        libngtcp2.so.16 => /opt/curl-quictls/ngtcp2/lib/libngtcp2.so.16 (0x00007f6fb70d5000)
        libnghttp2.so.14 => /lib64/libnghttp2.so.14 (0x00007f6fb6cfe000)
        libidn2.so.0 => /lib64/libidn2.so.0 (0x00007f6fb6ae0000)
        libssh2.so.1 => /lib64/libssh2.so.1 (0x00007f6fb68a0000)
        libpsl.so.5 => /lib64/libpsl.so.5 (0x00007f6fb668f000)
        libssl.so.81.3 => /opt/curl-quictls/quictls/lib64/libssl.so.81.3 (0x00007f6fb701a000)
        libcrypto.so.81.3 => /opt/curl-quictls/quictls/lib64/libcrypto.so.81.3 (0x00007f6fb616e000)
        libldap-2.4.so.2 => /lib64/libldap-2.4.so.2 (0x00007f6fb5f1f000)
        liblber-2.4.so.2 => /lib64/liblber-2.4.so.2 (0x00007f6fb5d0f000)
        libbrotlidec.so.1 => /opt/curl-quictls/brotli/lib64/libbrotlidec.so.1 (0x00007f6fb700a000)
        libz.so.1 => /lib64/libz.so.1 (0x00007f6fb5af7000)
        libzstd.so.1 => /opt/curl-quictls/zstd/lib/libzstd.so.1 (0x00007f6fb5a03000)
        libpthread.so.0 => /lib64/libpthread.so.0 (0x00007f6fb57e3000)
        libc.so.6 => /lib64/libc.so.6 (0x00007f6fb540d000)
        libunistring.so.2 => /lib64/libunistring.so.2 (0x00007f6fb508c000)
        libssl.so.1.1 => /lib64/libssl.so.1.1 (0x00007f6fb4df8000)
        libcrypto.so.1.1 => /lib64/libcrypto.so.1.1 (0x00007f6fb490d000)
        libdl.so.2 => /lib64/libdl.so.2 (0x00007f6fb4709000)
        libresolv.so.2 => /lib64/libresolv.so.2 (0x00007f6fb44f1000)
        libsasl2.so.3 => /lib64/libsasl2.so.3 (0x00007f6fb42d3000)
        libm.so.6 => /lib64/libm.so.6 (0x00007f6fb3f51000)
        libbrotlicommon.so.1 => /lib64/libbrotlicommon.so.1 (0x00007f6fb3d30000)
        /lib64/ld-linux-x86-64.so.2 (0x00007f6fb6f25000)
        libcrypt.so.1 => /lib64/libcrypt.so.1 (0x00007f6fb3b07000)
        libgssapi_krb5.so.2 => /lib64/libgssapi_krb5.so.2 (0x00007f6fb38b2000)
        libkrb5.so.3 => /lib64/libkrb5.so.3 (0x00007f6fb35c7000)
        libk5crypto.so.3 => /lib64/libk5crypto.so.3 (0x00007f6fb33b0000)
        libcom_err.so.2 => /lib64/libcom_err.so.2 (0x00007f6fb31ac000)
        libkrb5support.so.0 => /lib64/libkrb5support.so.0 (0x00007f6fb2f9b000)
        libkeyutils.so.1 => /lib64/libkeyutils.so.1 (0x00007f6fb2d97000)
        libselinux.so.1 => /lib64/libselinux.so.1 (0x00007f6fb2b6c000)
        libpcre2-8.so.0 => /lib64/libpcre2-8.so.0 (0x00007f6fb28e8000)
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
alt-svc: h3=":443"; ma=86400
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
alt-svc: h3=":443"; ma=86400
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

`testssl.sh` run via Centmin Mod's `tools/switch-nginx-ciphers.sh` tool.

```
/usr/local/src/centminmod/tools/switch-nginx-ciphers.sh testssl domain.com
testssl.sh --nodns=min --wide -p -c -f -E -S -P --quiet https://domain.com

 Start 2024-06-12 04:20:00                -->> 192.168.122.53:443 (domain.com) <<--

 Further IP addresses:   
 A record via:           /etc/hosts 
 rDNS (192.168.122.53):  (instructed to minimize DNS queries)
 Service detected:       HTTP


 Testing protocols via sockets except NPN+ALPN 

 SSLv2      not offered (OK)
 SSLv3      not offered (OK)
 TLS 1      not offered
 TLS 1.1    not offered
 TLS 1.2    offered (OK)
 TLS 1.3    offered (OK): final
 NPN/SPDY   not offered
 ALPN/HTTP2 h2, http/1.1 (offered)

 Testing server's cipher preferences 

Hexcode  Cipher Suite Name (OpenSSL)       KeyExch.   Encryption  Bits     Cipher Suite Name (IANA/RFC)
-----------------------------------------------------------------------------------------------------------------------------
SSLv2
 - 
SSLv3
 - 
TLSv1
 - 
TLSv1.1
 - 
TLSv1.2 (server order)
 xc02b   ECDHE-ECDSA-AES128-GCM-SHA256     ECDH 253   AESGCM      128      TLS_ECDHE_ECDSA_WITH_AES_128_GCM_SHA256            
 xc02c   ECDHE-ECDSA-AES256-GCM-SHA384     ECDH 253   AESGCM      256      TLS_ECDHE_ECDSA_WITH_AES_256_GCM_SHA384            
 xcca9   ECDHE-ECDSA-CHACHA20-POLY1305     ECDH 253   ChaCha20    256      TLS_ECDHE_ECDSA_WITH_CHACHA20_POLY1305_SHA256      
TLSv1.3 (no server order, thus listed by strength)
 x1302   TLS_AES_256_GCM_SHA384            ECDH 253   AESGCM      256      TLS_AES_256_GCM_SHA384                             
 x1303   TLS_CHACHA20_POLY1305_SHA256      ECDH 253   ChaCha20    256      TLS_CHACHA20_POLY1305_SHA256                       
 x1301   TLS_AES_128_GCM_SHA256            ECDH 253   AESGCM      128      TLS_AES_128_GCM_SHA256                             

 Has server cipher order?     yes (OK) -- only for < TLS 1.3


 Testing robust forward secrecy (FS) -- omitting Null Authentication/Encryption, 3DES, RC4 

 FS is offered (OK) , ciphers follow (client/browser support is important here) 

Hexcode  Cipher Suite Name (OpenSSL)       KeyExch.   Encryption  Bits     Cipher Suite Name (IANA/RFC)
-----------------------------------------------------------------------------------------------------------------------------
 x1302   TLS_AES_256_GCM_SHA384            ECDH 253   AESGCM      256      TLS_AES_256_GCM_SHA384                             
 x1303   TLS_CHACHA20_POLY1305_SHA256      ECDH 253   ChaCha20    256      TLS_CHACHA20_POLY1305_SHA256                       
 xc02c   ECDHE-ECDSA-AES256-GCM-SHA384     ECDH 256   AESGCM      256      TLS_ECDHE_ECDSA_WITH_AES_256_GCM_SHA384            
 xcca9   ECDHE-ECDSA-CHACHA20-POLY1305     ECDH 253   ChaCha20    256      TLS_ECDHE_ECDSA_WITH_CHACHA20_POLY1305_SHA256      
 x1301   TLS_AES_128_GCM_SHA256            ECDH 253   AESGCM      128      TLS_AES_128_GCM_SHA256                             
 xc02b   ECDHE-ECDSA-AES128-GCM-SHA256     ECDH 256   AESGCM      128      TLS_ECDHE_ECDSA_WITH_AES_128_GCM_SHA256            

 Elliptic curves offered:     prime256v1 secp384r1 X25519 
 TLS 1.2 sig_algs offered:    ECDSA+SHA256 ECDSA+SHA384 ECDSA+SHA512 ECDSA+SHA1 
 TLS 1.3 sig_algs offered:    ECDSA+SHA256 

 Testing server defaults (Server Hello) 

 TLS extensions (standard)    "server name/#0" "renegotiation info/#65281" "EC point formats/#11" "session ticket/#35"
                              "key share/#51" "supported versions/#43" "extended master secret/#23"
                              "application layer protocol negotiation/#16"
 Session Ticket RFC 5077 hint 3600 seconds, session tickets keys seems to be rotated < daily
 SSL Session ID support       yes
 Session Resumption           Tickets: yes, ID: yes
 TLS clock skew               Random values, no fingerprinting possible 
 Certificate Compression      none
 Client Authentication        none
 Signature Algorithm          ECDSA with SHA256
 Server key size              EC 256 bits (curve P-256)
 Server key usage             Digital Signature, Non Repudiation, Key Encipherment, Data Encipherment
 Server extended key usage    --
 Serial                       1EC9CFAD16D2BC2A42B2DB4A0D5AE7E572E5B3B7 (OK: length 20)
 Fingerprints                 SHA1 5EFC5FB06A26CBDA90D632401096EE53C037A40C
                              SHA256 6B61B19593FF5A21826228EE9DD89F2046597FD2D0AED30584B92393335E133F
 Common Name (CN)             domain.com 
 subjectAltName (SAN)         domain.com www.domain.com 
 Trust (hostname)             Ok via SAN and CN (same w/o SNI)
 Chain of trust               NOT ok (chain incomplete)
 EV cert (experimental)       no 
 Certificate Validity (UTC)   36499 >= 60 days (2024-06-11 17:11 --> 2124-05-18 17:11)
                              >= 10 years is way too long
 ETS/"eTLS", visibility info  not present
 Certificate Revocation List  --
 OCSP URI                     --
                              NOT ok -- neither CRL nor OCSP URI provided
 OCSP stapling                not offered
 OCSP must staple extension   --
 DNS CAA RR (experimental)    (instructed to minimize/skip DNS queries)
 Certificate Transparency     --
 Certificates provided        1
 Issuer                       domain.com (domain.com from US)
 Intermediate Bad OCSP (exp.) Ok



 Testing ciphers per protocol via OpenSSL plus sockets against the server, ordered by encryption strength 

Hexcode  Cipher Suite Name (OpenSSL)       KeyExch.   Encryption  Bits     Cipher Suite Name (IANA/RFC)
-----------------------------------------------------------------------------------------------------------------------------
SSLv2
 - 
SSLv3
 - 
TLS 1
 - 
TLS 1.1
 - 
TLS 1.2
 xc02c   ECDHE-ECDSA-AES256-GCM-SHA384     ECDH 256   AESGCM      256      TLS_ECDHE_ECDSA_WITH_AES_256_GCM_SHA384            
 xcca9   ECDHE-ECDSA-CHACHA20-POLY1305     ECDH 253   ChaCha20    256      TLS_ECDHE_ECDSA_WITH_CHACHA20_POLY1305_SHA256      
 xc02b   ECDHE-ECDSA-AES128-GCM-SHA256     ECDH 256   AESGCM      128      TLS_ECDHE_ECDSA_WITH_AES_128_GCM_SHA256            
TLS 1.3
 x1302   TLS_AES_256_GCM_SHA384            ECDH 253   AESGCM      256      TLS_AES_256_GCM_SHA384                             
 x1303   TLS_CHACHA20_POLY1305_SHA256      ECDH 253   ChaCha20    256      TLS_CHACHA20_POLY1305_SHA256                       
 x1301   TLS_AES_128_GCM_SHA256            ECDH 253   AESGCM      128      TLS_AES_128_GCM_SHA256                             

 Running client simulations (HTTP) via sockets 

 Browser                      Protocol  Cipher Suite Name (OpenSSL)       Forward Secrecy
------------------------------------------------------------------------------------------------
 Android 6.0                  TLSv1.2   ECDHE-ECDSA-AES128-GCM-SHA256     256 bit ECDH (P-256)
 Android 7.0 (native)         TLSv1.2   ECDHE-ECDSA-AES128-GCM-SHA256     256 bit ECDH (P-256)
 Android 8.1 (native)         TLSv1.2   ECDHE-ECDSA-AES128-GCM-SHA256     253 bit ECDH (X25519)
 Android 9.0 (native)         TLSv1.3   TLS_AES_128_GCM_SHA256            253 bit ECDH (X25519)
 Android 10.0 (native)        TLSv1.3   TLS_AES_128_GCM_SHA256            253 bit ECDH (X25519)
 Android 11 (native)          TLSv1.3   TLS_AES_128_GCM_SHA256            253 bit ECDH (X25519)
 Android 12 (native)          TLSv1.3   TLS_AES_128_GCM_SHA256            253 bit ECDH (X25519)
 Chrome 79 (Win 10)           TLSv1.3   TLS_AES_128_GCM_SHA256            253 bit ECDH (X25519)
 Chrome 101 (Win 10)          TLSv1.3   TLS_AES_128_GCM_SHA256            253 bit ECDH (X25519)
 Firefox 66 (Win 8.1/10)      TLSv1.3   TLS_AES_128_GCM_SHA256            253 bit ECDH (X25519)
 Firefox 100 (Win 10)         TLSv1.3   TLS_AES_128_GCM_SHA256            253 bit ECDH (X25519)
 IE 6 XP                      No connection
 IE 8 Win 7                   No connection
 IE 8 XP                      No connection
 IE 11 Win 7                  TLSv1.2   ECDHE-ECDSA-AES128-GCM-SHA256     256 bit ECDH (P-256)
 IE 11 Win 8.1                TLSv1.2   ECDHE-ECDSA-AES128-GCM-SHA256     256 bit ECDH (P-256)
 IE 11 Win Phone 8.1          TLSv1.2   ECDHE-ECDSA-AES128-GCM-SHA256     256 bit ECDH (P-256)
 IE 11 Win 10                 TLSv1.2   ECDHE-ECDSA-AES128-GCM-SHA256     256 bit ECDH (P-256)
 Edge 15 Win 10               TLSv1.2   ECDHE-ECDSA-AES128-GCM-SHA256     253 bit ECDH (X25519)
 Edge 101 Win 10 21H2         TLSv1.3   TLS_AES_128_GCM_SHA256            253 bit ECDH (X25519)
 Safari 12.1 (iOS 12.2)       TLSv1.3   TLS_CHACHA20_POLY1305_SHA256      253 bit ECDH (X25519)
 Safari 13.0 (macOS 10.14.6)  TLSv1.3   TLS_CHACHA20_POLY1305_SHA256      253 bit ECDH (X25519)
 Safari 15.4 (macOS 12.3.1)   TLSv1.3   TLS_AES_128_GCM_SHA256            253 bit ECDH (X25519)
 Java 7u25                    No connection
 Java 8u161                   TLSv1.2   ECDHE-ECDSA-AES128-GCM-SHA256     256 bit ECDH (P-256)
 Java 11.0.2 (OpenJDK)        TLSv1.3   TLS_AES_128_GCM_SHA256            256 bit ECDH (P-256)
 Java 17.0.3 (OpenJDK)        TLSv1.3   TLS_AES_256_GCM_SHA384            253 bit ECDH (X25519)
 go 1.17.8                    TLSv1.3   TLS_AES_128_GCM_SHA256            253 bit ECDH (X25519)
 LibreSSL 2.8.3 (Apple)       TLSv1.2   ECDHE-ECDSA-AES128-GCM-SHA256     253 bit ECDH (X25519)
 OpenSSL 1.0.2e               TLSv1.2   ECDHE-ECDSA-AES128-GCM-SHA256     256 bit ECDH (P-256)
 OpenSSL 1.1.0l (Debian)      TLSv1.2   ECDHE-ECDSA-AES128-GCM-SHA256     253 bit ECDH (X25519)
 OpenSSL 1.1.1d (Debian)      TLSv1.3   TLS_AES_256_GCM_SHA384            253 bit ECDH (X25519)
 OpenSSL 3.0.3 (git)          TLSv1.3   TLS_AES_256_GCM_SHA384            253 bit ECDH (X25519)
 Apple Mail (16.0)            TLSv1.2   ECDHE-ECDSA-AES128-GCM-SHA256     256 bit ECDH (P-256)
 Thunderbird (91.9)           TLSv1.3   TLS_AES_128_GCM_SHA256            253 bit ECDH (X25519)

 Done 2024-06-12 04:20:30 [  32s] -->> 192.168.122.53:443 (domain.com) <<--
```

nmap enumerate the SSL/TLS ciphers supported by the target server

```
nmap --script ssl-enum-ciphers -p 443 domain.com
Starting Nmap 7.92 ( https://nmap.org ) at 2024-06-12 04:18 UTC
Nmap scan report for domain.com (192.168.122.53)
Host is up (0.000053s latency).

PORT    STATE SERVICE
443/tcp open  https
| ssl-enum-ciphers: 
|   TLSv1.2: 
|     ciphers: 
|       TLS_ECDHE_ECDSA_WITH_AES_128_GCM_SHA256 (ecdh_x25519) - A
|       TLS_ECDHE_ECDSA_WITH_AES_256_GCM_SHA384 (ecdh_x25519) - A
|       TLS_ECDHE_ECDSA_WITH_CHACHA20_POLY1305_SHA256 (ecdh_x25519) - A
|     compressors: 
|       NULL
|     cipher preference: server
|   TLSv1.3: 
|     ciphers: 
|       TLS_AKE_WITH_AES_128_GCM_SHA256 (ecdh_x25519) - A
|       TLS_AKE_WITH_AES_256_GCM_SHA384 (ecdh_x25519) - A
|       TLS_AKE_WITH_CHACHA20_POLY1305_SHA256 (ecdh_x25519) - A
|     cipher preference: client
|_  least strength: A

Nmap done: 1 IP address (1 host up) scanned in 0.16 seconds
```

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
alt-svc: h3=":443"; ma=86400
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

`testssl.sh` run via Centmin Mod's `tools/switch-nginx-ciphers.sh` tool.

```
/usr/local/src/centminmod/tools/switch-nginx-ciphers.sh testssl domain.com
testssl.sh --nodns=min --wide -p -c -f -E -S -P --quiet https://domain.com

 Start 2024-06-12 04:10:11                -->> 192.168.122.53:443 (domain.com) <<--

 Further IP addresses:   
 A record via:           /etc/hosts 
 rDNS (192.168.122.53):  (instructed to minimize DNS queries)
 Service detected:       HTTP


 Testing protocols via sockets except NPN+ALPN 

 SSLv2      not offered (OK)
 SSLv3      not offered (OK)
 TLS 1      not offered
 TLS 1.1    not offered
 TLS 1.2    offered (OK)
 TLS 1.3    offered (OK): final
 NPN/SPDY   not offered
 ALPN/HTTP2 h2, http/1.1 (offered)

 Testing server's cipher preferences 

Hexcode  Cipher Suite Name (OpenSSL)       KeyExch.   Encryption  Bits     Cipher Suite Name (IANA/RFC)
-----------------------------------------------------------------------------------------------------------------------------
SSLv2
 - 
SSLv3
 - 
TLSv1
 - 
TLSv1.1
 - 
TLSv1.2 (server order)
 xc02b   ECDHE-ECDSA-AES128-GCM-SHA256     ECDH 253   AESGCM      128      TLS_ECDHE_ECDSA_WITH_AES_128_GCM_SHA256            
 xc02c   ECDHE-ECDSA-AES256-GCM-SHA384     ECDH 253   AESGCM      256      TLS_ECDHE_ECDSA_WITH_AES_256_GCM_SHA384            
 xcca9   ECDHE-ECDSA-CHACHA20-POLY1305     ECDH 253   ChaCha20    256      TLS_ECDHE_ECDSA_WITH_CHACHA20_POLY1305_SHA256      
TLSv1.3 (no server order, thus listed by strength)
 x1302   TLS_AES_256_GCM_SHA384            ECDH 253   AESGCM      256      TLS_AES_256_GCM_SHA384                             
 x1303   TLS_CHACHA20_POLY1305_SHA256      ECDH 253   ChaCha20    256      TLS_CHACHA20_POLY1305_SHA256                       
 x1301   TLS_AES_128_GCM_SHA256            ECDH 253   AESGCM      128      TLS_AES_128_GCM_SHA256                             

 Has server cipher order?     yes (OK) -- only for < TLS 1.3


 Testing robust forward secrecy (FS) -- omitting Null Authentication/Encryption, 3DES, RC4 

 FS is offered (OK) , ciphers follow (client/browser support is important here) 

Hexcode  Cipher Suite Name (OpenSSL)       KeyExch.   Encryption  Bits     Cipher Suite Name (IANA/RFC)
-----------------------------------------------------------------------------------------------------------------------------
 x1302   TLS_AES_256_GCM_SHA384            ECDH 253   AESGCM      256      TLS_AES_256_GCM_SHA384                             
 x1303   TLS_CHACHA20_POLY1305_SHA256      ECDH 253   ChaCha20    256      TLS_CHACHA20_POLY1305_SHA256                       
 xc02c   ECDHE-ECDSA-AES256-GCM-SHA384     ECDH 256   AESGCM      256      TLS_ECDHE_ECDSA_WITH_AES_256_GCM_SHA384            
 xcca9   ECDHE-ECDSA-CHACHA20-POLY1305     ECDH 253   ChaCha20    256      TLS_ECDHE_ECDSA_WITH_CHACHA20_POLY1305_SHA256      
 x1301   TLS_AES_128_GCM_SHA256            ECDH 253   AESGCM      128      TLS_AES_128_GCM_SHA256                             
 xc02b   ECDHE-ECDSA-AES128-GCM-SHA256     ECDH 256   AESGCM      128      TLS_ECDHE_ECDSA_WITH_AES_128_GCM_SHA256            

 Elliptic curves offered:     prime256v1 secp384r1 X25519 
 TLS 1.2 sig_algs offered:    ECDSA+SHA256 ECDSA+SHA384 ECDSA+SHA512 ECDSA+SHA1 
 TLS 1.3 sig_algs offered:    ECDSA+SHA256 

 Testing server defaults (Server Hello) 

 TLS extensions (standard)    "server name/#0" "renegotiation info/#65281" "EC point formats/#11" "session ticket/#35"
                              "key share/#51" "supported versions/#43" "extended master secret/#23"
                              "application layer protocol negotiation/#16"
 Session Ticket RFC 5077 hint 3600 seconds, session tickets keys seems to be rotated < daily
 SSL Session ID support       yes
 Session Resumption           Tickets: yes, ID: yes
 TLS clock skew               Random values, no fingerprinting possible 
 Certificate Compression      none
 Client Authentication        none
 Signature Algorithm          ECDSA with SHA256
 Server key size              EC 256 bits (curve P-256)
 Server key usage             Digital Signature, Non Repudiation, Key Encipherment, Data Encipherment
 Server extended key usage    --
 Serial                       1EC9CFAD16D2BC2A42B2DB4A0D5AE7E572E5B3B7 (OK: length 20)
 Fingerprints                 SHA1 5EFC5FB06A26CBDA90D632401096EE53C037A40C
                              SHA256 6B61B19593FF5A21826228EE9DD89F2046597FD2D0AED30584B92393335E133F
 Common Name (CN)             domain.com 
 subjectAltName (SAN)         domain.com www.domain.com 
 Trust (hostname)             Ok via SAN and CN (same w/o SNI)
 Chain of trust               NOT ok (chain incomplete)
 EV cert (experimental)       no 
 Certificate Validity (UTC)   36499 >= 60 days (2024-06-11 17:11 --> 2124-05-18 17:11)
                              >= 10 years is way too long
 ETS/"eTLS", visibility info  not present
 Certificate Revocation List  --
 OCSP URI                     --
                              NOT ok -- neither CRL nor OCSP URI provided
 OCSP stapling                not offered
 OCSP must staple extension   --
 DNS CAA RR (experimental)    (instructed to minimize/skip DNS queries)
 Certificate Transparency     --
 Certificates provided        1
 Issuer                       domain.com (domain.com from US)
 Intermediate Bad OCSP (exp.) Ok



 Testing ciphers per protocol via OpenSSL plus sockets against the server, ordered by encryption strength 

Hexcode  Cipher Suite Name (OpenSSL)       KeyExch.   Encryption  Bits     Cipher Suite Name (IANA/RFC)
-----------------------------------------------------------------------------------------------------------------------------
SSLv2
 - 
SSLv3
 - 
TLS 1
 - 
TLS 1.1
 - 
TLS 1.2
 xc02c   ECDHE-ECDSA-AES256-GCM-SHA384     ECDH 256   AESGCM      256      TLS_ECDHE_ECDSA_WITH_AES_256_GCM_SHA384            
 xcca9   ECDHE-ECDSA-CHACHA20-POLY1305     ECDH 253   ChaCha20    256      TLS_ECDHE_ECDSA_WITH_CHACHA20_POLY1305_SHA256      
 xc02b   ECDHE-ECDSA-AES128-GCM-SHA256     ECDH 256   AESGCM      128      TLS_ECDHE_ECDSA_WITH_AES_128_GCM_SHA256            
TLS 1.3
 x1302   TLS_AES_256_GCM_SHA384            ECDH 253   AESGCM      256      TLS_AES_256_GCM_SHA384                             
 x1303   TLS_CHACHA20_POLY1305_SHA256      ECDH 253   ChaCha20    256      TLS_CHACHA20_POLY1305_SHA256                       
 x1301   TLS_AES_128_GCM_SHA256            ECDH 253   AESGCM      128      TLS_AES_128_GCM_SHA256                             

 Running client simulations (HTTP) via sockets 

 Browser                      Protocol  Cipher Suite Name (OpenSSL)       Forward Secrecy
------------------------------------------------------------------------------------------------
 Android 6.0                  TLSv1.2   ECDHE-ECDSA-AES128-GCM-SHA256     256 bit ECDH (P-256)
 Android 7.0 (native)         TLSv1.2   ECDHE-ECDSA-AES128-GCM-SHA256     256 bit ECDH (P-256)
 Android 8.1 (native)         TLSv1.2   ECDHE-ECDSA-AES128-GCM-SHA256     253 bit ECDH (X25519)
 Android 9.0 (native)         TLSv1.3   TLS_AES_128_GCM_SHA256            253 bit ECDH (X25519)
 Android 10.0 (native)        TLSv1.3   TLS_AES_128_GCM_SHA256            253 bit ECDH (X25519)
 Android 11 (native)          TLSv1.3   TLS_AES_128_GCM_SHA256            253 bit ECDH (X25519)
 Android 12 (native)          TLSv1.3   TLS_AES_128_GCM_SHA256            253 bit ECDH (X25519)
 Chrome 79 (Win 10)           TLSv1.3   TLS_AES_128_GCM_SHA256            253 bit ECDH (X25519)
 Chrome 101 (Win 10)          TLSv1.3   TLS_AES_128_GCM_SHA256            253 bit ECDH (X25519)
 Firefox 66 (Win 8.1/10)      TLSv1.3   TLS_AES_128_GCM_SHA256            253 bit ECDH (X25519)
 Firefox 100 (Win 10)         TLSv1.3   TLS_AES_128_GCM_SHA256            253 bit ECDH (X25519)
 IE 6 XP                      No connection
 IE 8 Win 7                   No connection
 IE 8 XP                      No connection
 IE 11 Win 7                  TLSv1.2   ECDHE-ECDSA-AES128-GCM-SHA256     256 bit ECDH (P-256)
 IE 11 Win 8.1                TLSv1.2   ECDHE-ECDSA-AES128-GCM-SHA256     256 bit ECDH (P-256)
 IE 11 Win Phone 8.1          TLSv1.2   ECDHE-ECDSA-AES128-GCM-SHA256     256 bit ECDH (P-256)
 IE 11 Win 10                 TLSv1.2   ECDHE-ECDSA-AES128-GCM-SHA256     256 bit ECDH (P-256)
 Edge 15 Win 10               TLSv1.2   ECDHE-ECDSA-AES128-GCM-SHA256     253 bit ECDH (X25519)
 Edge 101 Win 10 21H2         TLSv1.3   TLS_AES_128_GCM_SHA256            253 bit ECDH (X25519)
 Safari 12.1 (iOS 12.2)       TLSv1.3   TLS_CHACHA20_POLY1305_SHA256      253 bit ECDH (X25519)
 Safari 13.0 (macOS 10.14.6)  TLSv1.3   TLS_CHACHA20_POLY1305_SHA256      253 bit ECDH (X25519)
 Safari 15.4 (macOS 12.3.1)   TLSv1.3   TLS_AES_128_GCM_SHA256            253 bit ECDH (X25519)
 Java 7u25                    No connection
 Java 8u161                   TLSv1.2   ECDHE-ECDSA-AES128-GCM-SHA256     256 bit ECDH (P-256)
 Java 11.0.2 (OpenJDK)        TLSv1.3   TLS_AES_128_GCM_SHA256            256 bit ECDH (P-256)
 Java 17.0.3 (OpenJDK)        TLSv1.3   TLS_AES_256_GCM_SHA384            253 bit ECDH (X25519)
 go 1.17.8                    TLSv1.3   TLS_AES_128_GCM_SHA256            253 bit ECDH (X25519)
 LibreSSL 2.8.3 (Apple)       TLSv1.2   ECDHE-ECDSA-AES128-GCM-SHA256     253 bit ECDH (X25519)
 OpenSSL 1.0.2e               TLSv1.2   ECDHE-ECDSA-AES128-GCM-SHA256     256 bit ECDH (P-256)
 OpenSSL 1.1.0l (Debian)      TLSv1.2   ECDHE-ECDSA-AES128-GCM-SHA256     253 bit ECDH (X25519)
 OpenSSL 1.1.1d (Debian)      TLSv1.3   TLS_AES_256_GCM_SHA384            253 bit ECDH (X25519)
 OpenSSL 3.0.3 (git)          TLSv1.3   TLS_AES_256_GCM_SHA384            253 bit ECDH (X25519)
 Apple Mail (16.0)            TLSv1.2   ECDHE-ECDSA-AES128-GCM-SHA256     256 bit ECDH (P-256)
 Thunderbird (91.9)           TLSv1.3   TLS_AES_128_GCM_SHA256            253 bit ECDH (X25519)

 Done 2024-06-12 04:10:40 [  31s] -->> 192.168.122.53:443 (domain.com) <<-
```

nmap enumerate the SSL/TLS ciphers supported by the target server

```
nmap --script ssl-enum-ciphers -p 443 domain.com
Starting Nmap 7.92 ( https://nmap.org ) at 2024-06-12 04:08 UTC
Nmap scan report for domain.com (192.168.122.53)
Host is up (0.000053s latency).
PORT    STATE SERVICE
443/tcp open  https
| ssl-enum-ciphers: 
|   TLSv1.2: 
|     ciphers: 
|       TLS_ECDHE_ECDSA_WITH_AES_128_GCM_SHA256 (ecdh_x25519) - A
|       TLS_ECDHE_ECDSA_WITH_AES_256_GCM_SHA384 (ecdh_x25519) - A
|       TLS_ECDHE_ECDSA_WITH_CHACHA20_POLY1305_SHA256 (ecdh_x25519) - A
|     compressors: 
|       NULL
|     cipher preference: server
|   TLSv1.3: 
|     ciphers: 
|       TLS_AKE_WITH_AES_128_GCM_SHA256 (ecdh_x25519) - A
|       TLS_AKE_WITH_AES_256_GCM_SHA384 (ecdh_x25519) - A
|       TLS_AKE_WITH_CHACHA20_POLY1305_SHA256 (ecdhx25519) - A
|     cipher preference: client
|  least strength: A
Nmap done: 1 IP address (1 host up) scanned in 0.18 seconds
```

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
alt-svc: h3=":443"; ma=86400
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
alt-svc: h3=":443"; ma=86400
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
alt-svc: h3=":443"; ma=86400
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

# Supported Ciphers

from OpenSSL

```
openssl ciphers -v
TLS_AES_256_GCM_SHA384  TLSv1.3 Kx=any      Au=any  Enc=AESGCM(256) Mac=AEAD
TLS_CHACHA20_POLY1305_SHA256 TLSv1.3 Kx=any      Au=any  Enc=CHACHA20/POLY1305(256) Mac=AEAD
TLS_AES_128_GCM_SHA256  TLSv1.3 Kx=any      Au=any  Enc=AESGCM(128) Mac=AEAD
TLS_AES_128_CCM_SHA256  TLSv1.3 Kx=any      Au=any  Enc=AESCCM(128) Mac=AEAD
ECDHE-ECDSA-AES256-GCM-SHA384 TLSv1.2 Kx=ECDH     Au=ECDSA Enc=AESGCM(256) Mac=AEAD
ECDHE-RSA-AES256-GCM-SHA384 TLSv1.2 Kx=ECDH     Au=RSA  Enc=AESGCM(256) Mac=AEAD
ECDHE-ECDSA-CHACHA20-POLY1305 TLSv1.2 Kx=ECDH     Au=ECDSA Enc=CHACHA20/POLY1305(256) Mac=AEAD
ECDHE-RSA-CHACHA20-POLY1305 TLSv1.2 Kx=ECDH     Au=RSA  Enc=CHACHA20/POLY1305(256) Mac=AEAD
ECDHE-ECDSA-AES256-CCM  TLSv1.2 Kx=ECDH     Au=ECDSA Enc=AESCCM(256) Mac=AEAD
ECDHE-ECDSA-AES128-GCM-SHA256 TLSv1.2 Kx=ECDH     Au=ECDSA Enc=AESGCM(128) Mac=AEAD
ECDHE-RSA-AES128-GCM-SHA256 TLSv1.2 Kx=ECDH     Au=RSA  Enc=AESGCM(128) Mac=AEAD
ECDHE-ECDSA-AES128-CCM  TLSv1.2 Kx=ECDH     Au=ECDSA Enc=AESCCM(128) Mac=AEAD
ECDHE-ECDSA-AES128-SHA256 TLSv1.2 Kx=ECDH     Au=ECDSA Enc=AES(128)  Mac=SHA256
ECDHE-RSA-AES128-SHA256 TLSv1.2 Kx=ECDH     Au=RSA  Enc=AES(128)  Mac=SHA256
ECDHE-ECDSA-AES256-SHA  TLSv1 Kx=ECDH     Au=ECDSA Enc=AES(256)  Mac=SHA1
ECDHE-RSA-AES256-SHA    TLSv1 Kx=ECDH     Au=RSA  Enc=AES(256)  Mac=SHA1
ECDHE-ECDSA-AES128-SHA  TLSv1 Kx=ECDH     Au=ECDSA Enc=AES(128)  Mac=SHA1
ECDHE-RSA-AES128-SHA    TLSv1 Kx=ECDH     Au=RSA  Enc=AES(128)  Mac=SHA1
AES256-GCM-SHA384       TLSv1.2 Kx=RSA      Au=RSA  Enc=AESGCM(256) Mac=AEAD
AES256-CCM              TLSv1.2 Kx=RSA      Au=RSA  Enc=AESCCM(256) Mac=AEAD
AES128-GCM-SHA256       TLSv1.2 Kx=RSA      Au=RSA  Enc=AESGCM(128) Mac=AEAD
AES128-CCM              TLSv1.2 Kx=RSA      Au=RSA  Enc=AESCCM(128) Mac=AEAD
AES256-SHA256           TLSv1.2 Kx=RSA      Au=RSA  Enc=AES(256)  Mac=SHA256
AES128-SHA256           TLSv1.2 Kx=RSA      Au=RSA  Enc=AES(128)  Mac=SHA256
AES256-SHA              SSLv3 Kx=RSA      Au=RSA  Enc=AES(256)  Mac=SHA1
AES128-SHA              SSLv3 Kx=RSA      Au=RSA  Enc=AES(128)  Mac=SHA1
DHE-RSA-AES256-GCM-SHA384 TLSv1.2 Kx=DH       Au=RSA  Enc=AESGCM(256) Mac=AEAD
DHE-RSA-CHACHA20-POLY1305 TLSv1.2 Kx=DH       Au=RSA  Enc=CHACHA20/POLY1305(256) Mac=AEAD
DHE-RSA-AES256-CCM      TLSv1.2 Kx=DH       Au=RSA  Enc=AESCCM(256) Mac=AEAD
DHE-RSA-AES128-GCM-SHA256 TLSv1.2 Kx=DH       Au=RSA  Enc=AESGCM(128) Mac=AEAD
DHE-RSA-AES128-CCM      TLSv1.2 Kx=DH       Au=RSA  Enc=AESCCM(128) Mac=AEAD
DHE-RSA-AES256-SHA256   TLSv1.2 Kx=DH       Au=RSA  Enc=AES(256)  Mac=SHA256
DHE-RSA-AES128-SHA256   TLSv1.2 Kx=DH       Au=RSA  Enc=AES(128)  Mac=SHA256
DHE-RSA-AES256-SHA      SSLv3 Kx=DH       Au=RSA  Enc=AES(256)  Mac=SHA1
DHE-RSA-AES128-SHA      SSLv3 Kx=DH       Au=RSA  Enc=AES(128)  Mac=SHA1
PSK-AES256-GCM-SHA384   TLSv1.2 Kx=PSK      Au=PSK  Enc=AESGCM(256) Mac=AEAD
PSK-CHACHA20-POLY1305   TLSv1.2 Kx=PSK      Au=PSK  Enc=CHACHA20/POLY1305(256) Mac=AEAD
PSK-AES256-CCM          TLSv1.2 Kx=PSK      Au=PSK  Enc=AESCCM(256) Mac=AEAD
PSK-AES128-GCM-SHA256   TLSv1.2 Kx=PSK      Au=PSK  Enc=AESGCM(128) Mac=AEAD
PSK-AES128-CCM          TLSv1.2 Kx=PSK      Au=PSK  Enc=AESCCM(128) Mac=AEAD
PSK-AES256-CBC-SHA      SSLv3 Kx=PSK      Au=PSK  Enc=AES(256)  Mac=SHA1
PSK-AES128-CBC-SHA256   TLSv1 Kx=PSK      Au=PSK  Enc=AES(128)  Mac=SHA256
PSK-AES128-CBC-SHA      SSLv3 Kx=PSK      Au=PSK  Enc=AES(128)  Mac=SHA1
DHE-PSK-AES256-GCM-SHA384 TLSv1.2 Kx=DHEPSK   Au=PSK  Enc=AESGCM(256) Mac=AEAD
DHE-PSK-CHACHA20-POLY1305 TLSv1.2 Kx=DHEPSK   Au=PSK  Enc=CHACHA20/POLY1305(256) Mac=AEAD
DHE-PSK-AES256-CCM      TLSv1.2 Kx=DHEPSK   Au=PSK  Enc=AESCCM(256) Mac=AEAD
DHE-PSK-AES128-GCM-SHA256 TLSv1.2 Kx=DHEPSK   Au=PSK  Enc=AESGCM(128) Mac=AEAD
DHE-PSK-AES128-CCM      TLSv1.2 Kx=DHEPSK   Au=PSK  Enc=AESCCM(128) Mac=AEAD
DHE-PSK-AES256-CBC-SHA  SSLv3 Kx=DHEPSK   Au=PSK  Enc=AES(256)  Mac=SHA1
DHE-PSK-AES128-CBC-SHA256 TLSv1 Kx=DHEPSK   Au=PSK  Enc=AES(128)  Mac=SHA256
DHE-PSK-AES128-CBC-SHA  SSLv3 Kx=DHEPSK   Au=PSK  Enc=AES(128)  Mac=SHA1
ECDHE-PSK-CHACHA20-POLY1305 TLSv1.2 Kx=ECDHEPSK Au=PSK  Enc=CHACHA20/POLY1305(256) Mac=AEAD
ECDHE-PSK-AES256-CBC-SHA TLSv1 Kx=ECDHEPSK Au=PSK  Enc=AES(256)  Mac=SHA1
ECDHE-PSK-AES128-CBC-SHA256 TLSv1 Kx=ECDHEPSK Au=PSK  Enc=AES(128)  Mac=SHA256
ECDHE-PSK-AES128-CBC-SHA TLSv1 Kx=ECDHEPSK Au=PSK  Enc=AES(128)  Mac=SHA1
```

from AWS-LC

```
/opt/aws-lc-install/bin/bssl ciphers -print-all
TLS_RSA_WITH_NULL_SHA
TLS_RSA_WITH_3DES_EDE_CBC_SHA
TLS_RSA_WITH_AES_128_CBC_SHA
TLS_RSA_WITH_AES_256_CBC_SHA
TLS_RSA_WITH_AES_128_CBC_SHA256
TLS_PSK_WITH_AES_128_CBC_SHA
TLS_PSK_WITH_AES_256_CBC_SHA
TLS_RSA_WITH_AES_128_GCM_SHA256
TLS_RSA_WITH_AES_256_GCM_SHA384
TLS_AES_128_GCM_SHA256
TLS_AES_256_GCM_SHA384
TLS_CHACHA20_POLY1305_SHA256
TLS_ECDHE_ECDSA_WITH_AES_128_CBC_SHA
TLS_ECDHE_ECDSA_WITH_AES_256_CBC_SHA
TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA
TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA
TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256
TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384
TLS_ECDHE_ECDSA_WITH_AES_128_GCM_SHA256
TLS_ECDHE_ECDSA_WITH_AES_256_GCM_SHA384
TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
TLS_ECDHE_PSK_WITH_AES_128_CBC_SHA
TLS_ECDHE_PSK_WITH_AES_256_CBC_SHA
TLS_ECDHE_RSA_WITH_CHACHA20_POLY1305_SHA256
TLS_ECDHE_ECDSA_WITH_CHACHA20_POLY1305_SHA256
TLS_ECDHE_PSK_WITH_CHACHA20_POLY1305_SHA256
```