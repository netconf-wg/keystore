
pyang -p ../ -f tree ../ietf-keystore@*.yang > ietf-keystore-tree.txt.tmp

fold -w 71 ietf-keystore-tree.txt.tmp > ietf-keystore-tree.txt

rm *-tree.txt.tmp
