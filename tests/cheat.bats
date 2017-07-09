#!/bin/env bats

@test "check for latest version of bash-snippets on update" {
  run cheat update
  [ "$status" -eq 0 ]
  [ "$output" = "Bash-Snippets is already the latest version" ]
}


@test "no arguments prints usage instructions" {
  run cheat
  [ $status -eq 0 ]
  [ "${lines[0]}" = "Cheat" ]
}

@test "grabbing information on a programming language (rust)" {
  run cheat rust
  [ $status -eq 0 ]
  result=$( echo $(cheat rust) | grep -Eo "Rust is a systems" )
  [ "$result" = "Rust is a systems" ]
}

@test "get the tools version with -v" {
  run cheat -v
  [ $status -eq 0 ]
  result=$( echo $(cheat -v) | grep -Eo "Version")
  [ "$result" = "Version" ]
}
