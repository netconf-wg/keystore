#!/bin/bash

echo "Testing ietf-keystore.yang (pyang)..."
pyang --ietf --max-line-length=69 -p ../ ../ietf-keystore\@*.yang
pyang --canonical -p ../ ../ietf-keystore\@*.yang

echo "Testing ietf-keystore.yang (yanglint)..."
yanglint ../ietf-keystore\@*.yang

echo "Testing ex-keystore.xml..."
yanglint -s ../ietf-keystore\@*.yang ../ietf-crypto-types\@*.yang ./ietf-origin.yang ex-keystore.xml

#echo "Testing ex-keystore-ce-notification.xml..."
#echo -e 'setns a=urn:ietf:params:xml:ns:neteonf:notification:1.0\nsetns b=urn:ietf:params:xml:ns:yang:ietf-keystore\ncat //a:notification/b:keystore' | xmllint --shell ex-keystore-ce-notification.xml | sed -e '/^\/.*/d' -e '/^ *$/d' > yanglint-notification.xml
#yanglint -s -t notif -r ex-keystore.xml ../ietf-*\@*.yang yanglint-notification.xml
#rm yanglint-notification.xml

echo "Testing ex-keystore-usage.yang (pyang)..."
pyang --lint --max-line-length=69 -p ../ ../ex-keystore-usage\@*.yang

echo "Testing ex-keystore-usage.yang (yanglint)..."
yanglint ../ex-keystore-usage\@*.yang

echo "Testing ex-keystore-usage.xml..."
yanglint -s -m ../ex-keystore-usage\@*.yang ../ietf-keystore\@*.yang ../ietf-crypto-types\@*.yang ./ietf-origin.yang  ex-keystore-usage.xml ex-keystore.xml

echo "Testing ex-generate-symmetric-key-rpc.xml..."
yanglint -s -t auto -O ex-keystore.xml ../ietf-*\@*.yang ex-generate-symmetric-key-rpc.xml

echo "Testing ex-generate-symmetric-key-rpc-reply.xml..."
yanglint -s -t auto -O ex-keystore.xml ../ietf-*\@*.yang ex-generate-symmetric-key-rpc-reply.xml ex-generate-symmetric-key-rpc.xml

echo "Testing ex-generate-asymmetric-key-rpc.xml..."
yanglint -s -t auto -O ex-keystore.xml ../ietf-*\@*.yang ex-generate-asymmetric-key-rpc.xml

echo "Testing ex-generate-asymmetric-key-rpc-reply.xml..."
yanglint -s -t auto -O ex-keystore.xml ../ietf-*\@*.yang ex-generate-asymmetric-key-rpc-reply.xml ex-generate-asymmetric-key-rpc.xml

