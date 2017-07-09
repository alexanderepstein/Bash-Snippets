#!/bin/env bats

@test "Testing stocks tool" {
   echo stocks
}

@test "Check for latest version of bash-snippets on update" {
  run stocks update
  [ "$status" -eq 0 ]
  [ "$output" = "Bash-Snippets is already the latest version" ]
}

@test "The -h option should print usage" {
  run stocks -h
  [ "$status" -eq 0 ]
  [ "${lines[0]}" = "Stocks" ]
}

@test "No arguments prints usage instructions" {
  run stocks
  [ "$status" -eq 0 ]
  [ "${lines[0]}" = "Stocks" ]
}

@test "Get the tools version with -v" {
  run stocks -v
  [ "$status" -eq 0 ]
  result=$( echo $(stocks -v) | grep -Eo "Version")
  [ "$result" = "Version" ]
}
