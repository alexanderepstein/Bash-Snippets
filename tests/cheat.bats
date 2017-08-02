#!/bin/env bats

@test "Testing cheat tool" {
   echo cheat
}

@test "Check for latest version of bash-snippets on update" {
  if [[ "$(uname)" == "Linux" ]];then
  run cheat update
  [ "$status" -eq 0 ]
  [ "$output" = "Bash-Snippets is already the latest version" ]
fi
}


@test "No arguments prints usage instructions" {
  run cheat
  [ "$status" -eq 0 ]
  [ "${lines[0]}" = "Cheat" ]
}

@test "The -h option should print usage" {
  run cheat -h
  [ "$status" -eq 0 ]
  [ "${lines[0]}" = "Cheat" ]
}

@test "Grabbing information on a programming language (rust)" {
  run cheat rust
  [ "$status" -eq 0 ]
  result=$( echo $(cheat rust) | grep -Eo "Rust is a systems" )
  [ "$result" = "Rust is a systems" ]
}


@test "Testing unkown topic due to misspelling" {
  result=$( echo $(cheat go operators) | grep -Eo "Unknown" )
  [ "$result" = "Unknown" ]
}

@test "Get the tools version with -v" {
  run cheat -v
  [ "$status" -eq 0 ]
  result=$( echo $(cheat -v) | grep -Eo "Version")
  [ "$result" = "Version" ]
}
