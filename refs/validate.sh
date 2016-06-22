#!/bin/sh

OUT=$2.tmp

cat > $OUT <<EOF
<data xmlns="urn:ietf:params:xml:ns:netconf:base:1.0">
EOF

cat $2 >> $OUT

cat >> $OUT <<EOF
</data>
EOF

echo
echo "converting yang to dsdl..."
yang2dsdl -t data ../$1
basename=`echo $1 | sed 's/\@.*//'`
echo

echo
echo "syntactic only validation (via xmlint)..."
xmllint --noout --relaxng $basename-data.rng  $OUT 
echo

echo
echo "syntactic only validation (via jing-trang)..."
#JING BROKE/Users/kwatsen/Juniper/version-control-servers/github/jing-trang/jing $basename-data.rng  $OUT
java -classpath "/Users/kwatsen/Juniper/version-control-servers/github/jing-trang/build/jing.jar" "com.thaiopensource.relaxng.util.Driver" $basename-data.rng  $OUT
echo

echo
echo "syntactic + semantic validation:"
#JING BROKE yang2dsdl -s -j -t data -b $basename -v $OUT  
yang2dsdl -s -t data -b $basename -v $OUT
echo

rm $OUT
rm *.rng *.dsrl *.sch

