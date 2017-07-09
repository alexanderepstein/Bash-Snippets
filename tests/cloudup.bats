#!/bin/env bats

@test "Testing cloudup tool" {
   echo cloudup
}

@test "Check for latest version of bash-snippets on update" {
  run cloudup update
  [ "$status" -eq 0 ]
  [ "$output" = "Bash-Snippets is already the latest version" ]
}

@test "The -h option should print usage" {
  run cloudup -h
  [ "$status" -eq 0 ]
  [ "${lines[0]}" = "Cloudup" ]
}

@test "Get the tools version with -v" {
  run cloudup -v
  [ "$status" -eq 0 ]
  result=$( echo $(cloudup -v) | grep -Eo "Version")
  [ "$result" = "Version" ]
}
