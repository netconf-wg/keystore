#!/bin/bash

run_unix_cmd() {
  # $1 is the line number
  # $2 is the cmd to run
  # $3 is the expected exit code
  output=`$2 2>&1`
  exit_code=$?
  if [[ $exit_code -ne $3 ]]; then
    printf "failed (incorrect exit status code) on line $1.\n"
    printf "  - exit code: $exit_code (expected $3)\n"
    printf "  - command: $2\n"
    if [[ -z $output ]]; then
      printf "  - output: <none>\n\n"
    else
      printf "  - output: <starts on next line>\n$output\n\n"
    fi
    exit 1
  fi
}

printf "Testing ietf-keystore.yang (pyang)..."
command="pyang --strict -Werror --ietf --max-line-length=69 -p ../ ../ietf-keystore\@*.yang ../ietf-crypto-types\@*.yang"
run_unix_cmd $LINENO "$command" 0
command="pyang --strict --canonical -p ../ ../ietf-keystore\@*.yang ../ietf-crypto-types\@*.yang"
run_unix_cmd $LINENO "$command" 0
printf "okay.\n"

printf "Testing ietf-keystore.yang (yanglint)..."
command="yanglint ../ietf-keystore\@*.yang ../ietf-crypto-types\@*.yang"
run_unix_cmd $LINENO "$command" 0
printf "okay.\n"

printf "Testing ex-keystore.xml..."
command="yanglint --features=ietf-crypto-types:hidden-keys,one-symmetric-key-format,symmetric-key-encryption,cms-enveloped-data-format,one-asymmetric-key-format,private-key-encryption,cms-encrypted-data-format --features=ietf-keystore:central-keystore-supported,symmetric-keys,asymmetric-keys ../ietf-keystore\@*.yang ../ietf-crypto-types\@*.yang ex-keystore.xml"
run_unix_cmd $LINENO "$command" 0
printf "okay.\n"

printf "Testing ex-keystore-default-operational.xml..."
command="yanglint ../ietf-keystore\@*.yang ../ietf-crypto-types\@*.yang ./ietf-origin.yang ex-keystore-default-operational.xml"
run_unix_cmd $LINENO "$command" 0
printf "okay.\n"

printf "Testing ex-keystore-default-running.xml..."
command="yanglint ../ietf-keystore\@*.yang ../ietf-crypto-types\@*.yang ex-keystore-default-running.xml"
run_unix_cmd $LINENO "$command" 0
printf "okay.\n"

printf "Testing ex-keystore-default-operational-applied.xml..."
command="yanglint ../ietf-keystore\@*.yang ../ietf-crypto-types\@*.yang ./ietf-origin.yang ex-keystore-default-operational-applied.xml"
run_unix_cmd $LINENO "$command" 0
printf "okay.\n"


printf "Testing ex-keystore-usage.yang (pyang)..."
command="pyang --strict --lint --max-line-length=69 -p ../ ../ex-keystore-usage\@*.yang"
run_unix_cmd $LINENO "$command" 0
printf "okay.\n"

printf "Testing ex-keystore-usage.yang (yanglint)..."
command="yanglint ../ex-keystore-usage\@*.yang"
run_unix_cmd $LINENO "$command" 0
printf "okay.\n"

printf "Testing ex-keystore-usage.xml..."
command="yanglint -m ../ex-keystore-usage\@*.yang ../ietf-keystore\@*.yang ../ietf-crypto-types\@*.yang ./ietf-origin.yang  ex-keystore-usage.xml ex-keystore.xml"
run_unix_cmd $LINENO "$command" 0
printf "okay.\n"

#printf "Testing ex-generate-symmetric-key-rpc.xml..."
#command="yanglint -t auto -O ex-keystore.xml ../ietf-*\@*.yang ex-generate-symmetric-key-rpc.xml"
#run_unix_cmd $LINENO "$command" 0
#printf "okay.\n"
#
#printf "Testing ex-generate-symmetric-key-rpc-reply.xml..."
#command="yanglint -t auto -O ex-keystore.xml ../ietf-*\@*.yang ex-generate-symmetric-key-rpc-reply.xml ex-generate-symmetric-key-rpc.xml"
#run_unix_cmd $LINENO "$command" 0
#printf "okay.\n"
#
#printf "Testing ex-generate-asymmetric-key-rpc.xml..."
#command="yanglint -t auto -O ex-keystore.xml ../ietf-*\@*.yang ex-generate-asymmetric-key-rpc.xml"
#run_unix_cmd $LINENO "$command" 0
#printf "okay.\n"
#
#printf "Testing ex-generate-asymmetric-key-rpc-reply.xml..."
#command="yanglint -t auto -O ex-keystore.xml ../ietf-*\@*.yang ex-generate-asymmetric-key-rpc-reply.xml ex-generate-asymmetric-key-rpc.xml"
#run_unix_cmd $LINENO "$command" 0
#printf "okay.\n"

printf "Testing ex-notification-ce.xml..."
echo -e 'setns a=urn:ietf:params:xml:ns:netconf:notification:1.0\nsetns b=urn:ietf:params:xml:ns:yang:ietf-keystore\ncat //a:notification/b:keystore' | xmllint --shell ex-notification-ce.xml | sed -e '/^\/.*/d' -e '/^ *$/d' > yanglint-notification.xml
command="yanglint -t notif -O ex-keystore.xml ../ietf-crypto-types@*.yang ../ietf-keystore@*.yang yanglint-notification.xml"
run_unix_cmd $LINENO "$command" 0
printf "okay.\n"
rm yanglint-notification.xml
