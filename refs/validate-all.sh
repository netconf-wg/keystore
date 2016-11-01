
echo "Testing YANG syntax..."
pyang --ietf --max-line-length=70 -p ../ ../ietf-keystore\@*.yang

echo "Testing keystore module..."
./validate.sh ietf-keystore\@*.yang ex-keystore.xml
#./validate.sh ietf-keystore\@*.yang ex-keystore-rpc-gpk-restconf-json.xml
#./validate.sh ietf-keystore\@*.yang ex-keystore-rpc-gcsr-netconf.xml

