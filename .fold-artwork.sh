#!/bin/bash
#
# the only reason why /bin/sh isn't being used 
# is because "echo -n" is broken on the Mac.

print_usage() {
  echo
  echo "Wraps file representing IETF artwork at specified column"
  echo "according to BCP XX.  Note, this routine does nothing if"
  echo "the infile has no lines longer than specified."
  echo
  echo "Usage: $0 [-r] [-c <col>] -i <infile> -o <outfile>"
  echo
  echo "  -c: column to wrap on (default: 69)"
  echo "  -r: reverses the operation"
  echo "  -i: the input filename"
  echo "  -o: the output filename"
  echo "  -h: show this message"
  echo
  echo "Exit status code: zero on success, non-zero otherwise."
  echo
}


# global vars, do not edit
reversed=0
infile=""
outfile=""
maxcol=69  # default, may be overridden by param
header="\n[Note: '\' line wrapping for formatting only]\n\n"


fold_it() {
  # check if file needs folding
  grep ".\{$maxcol\}" $infile >> /dev/null 2>&1
  if [ $? -ne 0 ]; then
    # nothing to do
    cp $infile $outfile
    return 1
  fi

  echo -ne "$header" > $outfile
  foldcol=`expr "$maxcol" - 1` # spacer for the inserted '\' char
  gsed "s/\(.\{$foldcol\}\)/\1\\\\\n/" < $infile >> $outfile
  return 0
}


unfold_it() {
  # count lines in header
  numlines=`echo -ne "$header" | wc -l`

  # check if file needs unfolding
  echo -ne "$header" > /tmp/header
  head -n $numlines $infile > /tmp/header2
  diff -q /tmp/header /tmp/header2 >> /dev/null
  code=$?
  rm /tmp/header /tmp/header2
  if [ $code -ne 0 ]; then
    # nothing to do
    cp $infile $outfile
    return 1
  fi

  awk "NR>$numlines" $infile > /tmp/wip
  gsed ':x; /\\$/ { N; s/\\\n//; tx }' /tmp/wip > $outfile
  rm /tmp/wip
  return 0
}


process_input() {
  while [ "$1" != "" ]; do
    if [ "$1" == "-h" -o "$1" == "--help" ]; then
      print_usage
      exit 1
    fi
    if [ "$1" == "-c" ]; then
      maxcol="$2"
      shift
    fi
    if [ "$1" == "-r" ]; then
      reversed=1
    fi
    if [ "$1" == "-i" ]; then
      infile="$2"
      shift
    fi
    if [ "$1" == "-o" ]; then
      outfile="$2"
      shift
    fi
    shift 
  done

  if [ -z "$infile" ]; then
    echo "error: infile parameter missing."
    exit 1
  fi

  if [ -z "$outfile" ]; then
    echo "error: outfile parameter missing."
    exit 1
  fi

  if [ ! -f "$infile" ]; then
    echo "error: infile \"$infile\" does not exist."
    exit 1
  fi

  if [ -f "$outfile" ]; then
    echo "warning: outfile \"$outfile\" already exists."
  fi
}


main() {
  if [ "$#" == "0" ]; then
     print_usage
     exit 1
  fi

  process_input $@

  if [[ $reversed -eq 0 ]]; then
    fold_it
  else
    unfold_it
  fi
  exit 0
}

main "$@"
