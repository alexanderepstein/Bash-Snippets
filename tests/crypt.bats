#!/bin/env bats

@test "Testing crypt tool" {
   echo crypt
}

@test "Check for latest version of bash-snippets on update" {
  if [[ "$(uname)" == "Linux" ]];then
  run crypt update
  [ "$status" -eq 0 ]
  [ "$output" = "Bash-Snippets is already the latest version" ]
fi
}

@test "The -h option should print usage" {
  run crypt -h
  [ "$status" -eq 0 ]
  [ "${lines[0]}" = "Crypt" ]
}

@test "No arguments prints usage instructions" {
  run crypt
  [ "$status" -eq 0 ]
  [ "${lines[0]}" = "Crypt" ]
}


@test "Get the tools version with -v" {
  run crypt -v
  [ "$status" -eq 0 ]
  result=$( echo $(crypt -v) | grep -Eo "Version")
  [ "$result" = "Version" ]
}
