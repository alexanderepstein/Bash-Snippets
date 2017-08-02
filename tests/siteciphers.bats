#!/bin/env bats

@test "Testing siteciphers tool" {
   echo siteciphers
}

@test "Check for latest version of bash-snippets on update" {
  if [[ "$(uname)" == "Linux" ]];then
  run siteciphers update
  [ "$status" -eq 0 ]
  [ "$output" = "Bash-Snippets is already the latest version" ]
fi
}

@test "No arguments prints usage instructions" {
  run siteciphers
  [ "$status" -eq 1 ]
  [ "${lines[0]}" = "Siteciphers" ]
}

@test "The -h option should print usage" {
  run siteciphers -h
  [ "$status" -eq 0 ]
  [ "${lines[0]}" = "Siteciphers" ]
}

#@test "Running siteciphers on travis-ci" {
#  run siteciphers travis-ci.org
#  [ "$status" -eq 0 ]
#  [ "${lines[0]}" = "ECDHE-RSA-AES256-GCM-SHA384 - NO (tlsv1 alert insufficient security)" ]
#}


@test "Get the tools version with -v" {
  run siteciphers -v
  [ "$status" -eq 0 ]
  result=$( echo $(siteciphers -v) | grep -Eo "Version")
  [ "$result" = "Version" ]
}
