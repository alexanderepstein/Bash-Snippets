#!/bin/env bats

@test "Testing weather tool" {
   echo weather
}

@test "Check for latest version of bash-snippets on update" {
  run weather update
  [ "$status" -eq 0 ]
  [ "$output" = "Bash-Snippets is already the latest version" ]
}

@test "The -h option should print usage" {
  run weather -h
  [ "$status" -eq 0 ]
  [ "${lines[0]}" = "Weather" ]
}

@test "Get the tools version with -v" {
  run weather -v
  [ "$status" -eq 0 ]
  result=$( echo $(cheat -v) | grep -Eo "Version")
  [ "$result" = "Version" ]
}
