
echo "Testing ietf-keystore.yang..."
pyang --ietf --max-line-length=70 -p ../ ../ietf-keystore\@*.yang
pyang --canonical -p ../ ../ietf-keystore\@*.yang
yanglint ../ietf-keystore\@*.yang

echo "Testing ex-keystore.xml..."
yanglint -s ../ietf-keystore\@*.yang ex-keystore.xml

echo "Testing ex-keystore-gpk-rpc.xml..."
yanglint -t auto -s ../ietf-keystore\@*.yang ex-keystore-gpk-rpc.xml

echo "Testing ex-keystore-gpk-rpc-reply.xml..."
yanglint -t auto -s ../ietf-keystore\@*.yang ex-keystore-gpk-rpc-reply.xml ex-keystore-gpk-rpc.xml

echo "Testing ex-keystore-gcsr-rpc.xml..."
yanglint -t auto -s ../ietf-keystore\@*.yang ex-keystore-gcsr-rpc.xml

echo "Testing ex-keystore-gcsr-rpc-reply.xml..."
yanglint -t auto -s ../ietf-keystore\@*.yang ex-keystore-gcsr-rpc-reply.xml ex-keystore-gcsr-rpc.xml

echo "Testing ex-keystore-ce-notification.xml..."
yanglint -r ex-keystore.xml -t auto -s ../ietf-keystore\@*.yang ex-keystore-ce-notification.xml

