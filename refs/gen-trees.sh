echo "Generating tree diagrams..."

#pyang -p ../ -f tree --tree-line-length 69 --tree-print-groupings ../ietf-keystore@*.yang > ietf-keystore-tree.txt
#pyang -p ../ -f tree --tree-line-length 69 --tree-print-groupings --tree-no-expand-uses ../ietf-keystore@*.yang > ietf-keystore-tree-no-expand.txt
#
#pyang -p ../ -f tree --tree-line-length 69 --tree-print-groupings ../ex-keystore-usage@*.yang > ex-keystore-usage-tree.txt
#pyang -p ../ -f tree --tree-line-length 69 --tree-print-groupings --tree-no-expand-uses  ../ex-keystore-usage@*.yang > ex-keystore-usage-tree-no-expand.txt
pyang -p ../ -f tree --tree-line-length 69 ../ietf-keystore@*.yang > ietf-keystore-tree.txt
pyang -p ../ -f tree --tree-line-length 69 --tree-no-expand-uses ../ietf-keystore@*.yang > ietf-keystore-tree-no-expand.txt

pyang -p ../ -f tree --tree-line-length 69 ../ex-keystore-usage@*.yang > ex-keystore-usage-tree.txt
pyang -p ../ -f tree --tree-line-length 69 --tree-no-expand-uses  ../ex-keystore-usage@*.yang > ex-keystore-usage-tree-no-expand.txt


extract_grouping_with_params() {
  # $1 name of grouping
  # $2 addition CLI params
  # $3 output filename
  pyang -p ../ -f tree --tree-line-length 69 --tree-print-groupings $2 ../ietf-keystore@*.yang > ex-keystore-groupings-tree.txt
  cat ex-keystore-groupings-tree.txt | sed -n "/^  grouping $1/,/^  grouping/p" > tmp
  c=$(grep -c "^  grouping" tmp)
  if [ "$c" -ne "1" ]; then
    ghead -n -1 tmp > $3
    rm tmp
  else
    mv tmp $3
  fi
}

extract_grouping() {
  # $1 name of grouping
  #extract_grouping_with_params "$1" "" "tree-$1.expanded.txt"
  extract_grouping_with_params "$1" "--tree-no-expand-uses" "tree-$1.no-expand.txt"
}

extract_grouping encrypted-by-grouping
extract_grouping asymmetric-key-certificate-ref-grouping
extract_grouping inline-or-keystore-symmetric-key-grouping
extract_grouping inline-or-keystore-asymmetric-key-grouping
extract_grouping inline-or-keystore-asymmetric-key-with-certs-grouping
extract_grouping inline-or-keystore-end-entity-cert-with-key-grouping
extract_grouping keystore-grouping

