#!/bin/sh

### Universal
    # Paquetes temporales
    rm -rf /var/cache/apk/* /var/cache/apt/* /var/lib/apt/lists/* /tmp/* /var/tmp/* 
    # Cache de paquetes
    rm -rf ~/.cache /root/.cache

### Specific
