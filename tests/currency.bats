#!/bin/env bats

@test "Testing currency tool" {
   echo currency
}

@test "Check for latest version of bash-snippets on update" {
  run currency update
  [ "$status" -eq 0 ]
  [ "$output" = "Bash-Snippets is already the latest version" ]
}

@test "The -h option should print usage" {
  run currency -h
  [ "$status" -eq 0 ]
  [ "${lines[0]}" = "Currency" ]
}

@test "Get the tools version with -v" {
  run currency -v
  [ "$status" -eq 0 ]
  result=$( echo $(currency -v) | grep -Eo "Version")
  [ "$result" = "Version" ]
}
