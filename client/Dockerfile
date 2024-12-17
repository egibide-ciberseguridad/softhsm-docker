# Copyright 2021 by Vegard IT GmbH, Germany, https://vegardit.com
# SPDX-License-Identifier: Apache-2.0
#
# Author: Sebastian Thomschke, Vegard IT GmbH
#
# https://github.com/vegardit/docker-softhsm2-pkcs11-proxy

FROM alpine:latest

# install pkcs11-tool
RUN apk add --no-cache opensc openssl bash

# install libpkcs11-proxy.so
COPY --from=vegardit/softhsm2-pkcs11-proxy:latest-alpine /usr/local/lib/libpkcs11-proxy* /usr/local/lib/

# install test TLS Pre-Shared Key
COPY --from=vegardit/softhsm2-pkcs11-proxy:latest-alpine /opt/test.tls.psk /opt/test.tls.psk

RUN echo "alias p11tool='pkcs11-tool --module /usr/local/lib/libpkcs11-proxy.so'" > /etc/bash/99_pkcs11_tool.sh

WORKDIR /root
