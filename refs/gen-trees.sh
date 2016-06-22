
pyang -p ../ -f tree ../ietf-system-keychain@*.yang > ietf-system-keychain-tree.txt.tmp

fold -w 71 ietf-system-keychain-tree.txt.tmp > ietf-system-keychain-tree.txt

rm *-tree.txt.tmp
