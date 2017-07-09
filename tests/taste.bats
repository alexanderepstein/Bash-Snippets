#!/bin/env bats

@test "Testing taste tool" {
   echo taste
}

@test "Check for latest version of bash-snippets on update" {
  run taste update
  [ "$status" -eq 0 ]
  [ "$output" = "Bash-Snippets is already the latest version" ]
}

@test "The -h option should print usage" {
  run taste -h
  [ "$status" -eq 0 ]
  [ "${lines[0]}" = "Taste" ]
}

@test "No arguments prints usage instructions" {
  run taste
  [ "$status" -eq 0 ]
  [ "${lines[0]}" = "Taste" ]
}

@test "Get the tools version with -v" {
  run taste -v
  [ "$status" -eq 0 ]
  result=$( echo $(taste -v) | grep -Eo "Version")
  [ "$result" = "Version" ]
}
