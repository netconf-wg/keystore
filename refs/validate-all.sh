
echo "Testing ietf-keystore.yang (pyang)..."
pyang --ietf --max-line-length=70 -p ../ ../ietf-keystore\@*.yang
pyang --canonical -p ../ ../ietf-keystore\@*.yang

echo "Testing ietf-keystore.yang (yanglint)..."
yanglint ../ietf-keystore\@*.yang

echo "Testing ex-keystore.xml..."
yanglint -s ../ietf-keystore\@*.yang ex-keystore.xml

echo "Testing ex-keystore-ce-notification.xml..."
yanglint -r ex-keystore.xml -t auto -s ../ietf-keystore\@*.yang ex-keystore-ce-notification.xml

echo "Testing ex-keystore-usage.yang (pyang)..."
pyang --lint --max-line-length=70 -p ../ ../ex-keystore-usage\@*.yang

echo "Testing ex-keystore-usage.yang (yanglint)..."
yanglint ../ex-keystore-usage\@*.yang

echo "Testing ex-keystore-usage.xml..."
yanglint -p ../ -s ../ex-keystore-usage\@*.yang ../ietf-keystore\@*.yang ex-keystore-usage.xml

echo "Testing ex-keystore-gpk-rpc.xml..."
yanglint -p ../ -t auto -s ../ex-keystore-usage\@*.yang ../ietf-keystore\@*.yang ex-keystore-gpk-rpc.xml

echo "Testing ex-keystore-gpk-rpc-reply.xml..."
yanglint -p ../ -t auto -s ../ex-keystore-usage\@*.yang ../ietf-keystore\@*.yang ex-keystore-gpk-rpc-reply.xml ex-keystore-gpk-rpc.xml

echo "Testing ex-keystore-gcsr-rpc.xml..."
yanglint -p ../ -t auto -s ../ex-keystore-usage\@*.yang ../ietf-keystore\@*.yang ex-keystore-gcsr-rpc.xml

echo "Testing ex-keystore-gcsr-rpc-reply.xml..."
yanglint -p ../ -t auto -s ../ex-keystore-usage\@*.yang ../ietf-keystore\@*.yang ex-keystore-gcsr-rpc-reply.xml ex-keystore-gcsr-rpc.xml

