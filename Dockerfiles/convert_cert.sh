#!/bin/bash
input_file="/etc/phpmyadmin/ca-certificate.crt"
content=$(<"$input_file")
formatted_content=$(echo "$content" | sed -e 's/-----BEGIN CERTIFICATE-----/&\n/' -e 's/-----END CERTIFICATE-----/\n&/' | awk '
BEGIN {RS=""; FS="\n"}
{
    print $1;  # Print the BEGIN line
    body = substr($0, length($1) + 2, length($0) - length($1) - length($NF) - 3);
    gsub(/ /, "", body);
    len = length(body);
    for (i=1; i<=len; i+=64) {
        print substr(body, i, 64);
    }
    print $NF;
}')
echo $formatted_content > /etc/phpmyadmin/ca-certificate.crt