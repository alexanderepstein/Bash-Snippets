#!/bin/env bats

@test "Testing ytview tool" {
   echo ytview
}

@test "Check for latest version of bash-snippets on update" {
  run ytview update
  [ "$status" -eq 0 ]
  [ "$output" = "Bash-Snippets is already the latest version" ]
}

@test "The -h option should print usage" {
  run ytview -h
  [ "$status" -eq 0 ]
  [ "${lines[0]}" = "Ytview" ]
}

@test "No arguments prints usage instructions" {
  run ytview
  [ "$status" -eq 0 ]
  [ "${lines[0]}" = "Ytview" ]
}

@test "Get the tools version with -v" {
  run ytview -v
  [ "$status" -eq 0 ]
  result=$( echo $(cheat -v) | grep -Eo "Version")
  [ "$result" = "Version" ]
}
