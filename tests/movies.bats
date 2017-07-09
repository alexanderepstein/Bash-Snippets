#!/bin/env bats

@test "Testing movies tool" {
   echo movies
}

@test "Check for latest version of bash-snippets on update" {
  run movies update
  [ "$status" -eq 0 ]
  [ "$output" = "Bash-Snippets is already the latest version" ]
}

@test "The -h option should print usage" {
  run movies -h
  [ "$status" -eq 0 ]
  [ "${lines[0]}" = "Movies" ]
}

@test "No arguments prints usage instructions" {
  run movies
  [ "$status" -eq 0 ]
  [ "${lines[0]}" = "Movies" ]
}

@test "Get the tools version with -v" {
  run movies -v
  [ "$status" -eq 0 ]
  result=$( echo $(cheat -v) | grep -Eo "Version")
  [ "$result" = "Version" ]
}
