
pyang -p ../ -f tree --tree-line-length 69 --tree-print-groupings ../ietf-keystore@*.yang > ietf-keystore-tree.txt

pyang -p ../ -f tree --tree-line-length 69 --tree-print-groupings --tree-no-expand-uses ../ietf-keystore@*.yang > ietf-keystore-tree-no-expand.txt

