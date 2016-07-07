
echo "Testing YANG syntax..."
pyang --ietf --max-line-length=70 -p ../ ../ietf-system-keychain\@*.yang

echo "Testing keychain module..."
./validate.sh ietf-system-keychain\@*.yang ex-system-keychain.xml
#./validate.sh ietf-system-keychain\@*.yang ex-system-keychain-rpc-gpk-restconf-json.xml
#./validate.sh ietf-system-keychain\@*.yang ex-system-keychain-rpc-gcsr-netconf.xml

