#!/bin/env bats

@test "Testing qrify tool" {
   echo qrify
}

@test "Check for latest version of bash-snippets on update" {
  run qrify update
  [ "$status" -eq 0 ]
  [ "$output" = "Bash-Snippets is already the latest version" ]
}

@test "The -h option should print usage" {
  run qrify -h
  [ "$status" -eq 0 ]
  [ "${lines[0]}" = "Qrify" ]
}

@test "No arguments prints usage instructions" {
  run qrify
  [ "$status" -eq 0 ]
  [ "${lines[0]}" = "Qrify" ]
}

@test "Get the tools version with -v" {
  run qrify -v
  [ "$status" -eq 0 ]
  result=$( echo $(cheat -v) | grep -Eo "Version")
  [ "$result" = "Version" ]
}
