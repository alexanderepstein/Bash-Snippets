#!/bin/env bats

@test "Testing ytview tool" {
   echo ytview
}

@test "Check for latest version of bash-snippets on update" {
  if [[ "$(uname)" == "Linux" ]];then
  run ytview update
  [ "$output" = "Bash-Snippets is already the latest version" ]
fi
}

@test "The -h option should print usage" {
  run ytview -h
  [ "${lines[0]}" = "Ytview" ]
}

@test "No arguments prints usage instructions" {
  run ytview
  [ "$status" -eq 0 ]
  [ "${lines[0]}" = "Ytview" ]
}

@test "Get the tools version with -v" {
  result=$( echo $(ytview -v) | grep -Eo "Version")
  [ "$result" = "Version" ]
}
