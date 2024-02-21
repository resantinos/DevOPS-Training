#!/bin/bash

# Input file containing the certificate in one line
input_file="/etc/phpmyadmin/ca-certificate.crt"
# Output file for the formatted certificate
output_file="/etc/phpmyadmin/ca-certificate.crt"

# Read the content of the certificate file
content=$(<"$input_file")

# Format the certificate
formatted_content=$(echo "$content" | sed -e 's/-----BEGIN CERTIFICATE-----/&\n/' -e 's/-----END CERTIFICATE-----/\n&/' | awk '
BEGIN {RS=""; FS="\n"}
{
    print $1;  # Print the BEGIN line
    body = substr($0, length($1) + 2, length($0) - length($1) - length($NF) - 3);  # Extract the certificate body excluding markers
    gsub(/ /, "", body);  # Remove spaces in the body
    len = length(body);
    for (i=1; i<=len; i+=64) {
        print substr(body, i, 64);  # Print the body in 64-character chunks
    }
    print $NF;  # Print the END line
}')

# Save the formatted content to the output file
echo "$formatted_content" > "$output_file"

echo "Certificate has been formatted and saved to $output_file."