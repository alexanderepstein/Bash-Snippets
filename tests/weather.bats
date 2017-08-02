#!/bin/env bats

@test "Testing weather tool" {
   echo weather
}

@test "Check for latest version of bash-snippets on update" {
  if [[ "$(uname)" == "Linux" ]];then
  run weather update
  [ "$status" -eq 0 ]
  [ "$output" = "Bash-Snippets is already the latest version" ]
fi
}

@test "The -h option should print usage" {
  run weather -h
  [ "$status" -eq 0 ]
  [ "${lines[0]}" = "Weather" ]
}

@test "Testing weather with specified location" {
  run weather Paramus
  [ "$status" -eq 0 ]
  [ "${lines[0]}" = "Weather report: Paramus, United States of America" ]
}

@test "Get the tools version with -v" {
  run weather -v
  [ "$status" -eq 0 ]
  result=$( echo $(weather -v) | grep -Eo "Version")
  [ "$result" = "Version" ]
}
