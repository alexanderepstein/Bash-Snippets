#!/bin/env bats

@test "Testing geo tool" {
   echo geo
}

@test "Check for latest version of bash-snippets on update" {
  run geo update
  [ "$status" -eq 0 ]
  [ "$output" = "Bash-Snippets is already the latest version" ]
}

@test "The -h option should print usage" {
  run geo -h
  [ "$status" -eq 0 ]
  [ "${lines[0]}" = "Geo" ]
}

@test "Get the tools version with -v" {
  run geo -v
  [ "$status" -eq 0 ]
  result=$( echo $(cheat -v) | grep -Eo "Version")
  [ "$result" = "Version" ]
}
