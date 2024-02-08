#!/bin/sh

XML_FILE="/opt/traccar/conf/traccar.xml"

set -e

cat > $XML_FILE << EOF
<?xml version='1.0' encoding='UTF-8'?>
<!DOCTYPE properties SYSTEM 'http://java.sun.com/dtd/properties.dtd'>
<properties>
    <entry key='config.default'>./conf/default.xml</entry>
EOF

for path in /opt/traccar/conf-*/*; do
    key=$(basename $path)
    val=$(cat $path)
    echo "    <entry key='$(xmlstarlet escape "$key")'>$(xmlstarlet escape "$val")</entry>" >> $XML_FILE
done

cat >> $XML_FILE << EOF
</properties>
EOF
