#!/bin/bash

printcert() {
    if [ $# -lt 1 ]; then
        echo "Need address" 2>&1
        exit 1
    fi

    echo | openssl s_client -showcerts -servername "$1" -connect "$1":443 2>/dev/null | openssl x509 -inform pem -noout -text
}

cert() {
    echo -n | openssl s_client -connect "$1" | sed -ne /-BEGIN CERTIFICATE-/,/-END CERTIFICATE-/p
}
