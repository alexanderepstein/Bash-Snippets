#!/bin/env bats

@test "Testing short tool" {
   echo short
}

@test "Check for latest version of bash-snippets on update" {
  if [[ "$(uname)" == "Linux" ]];then
  run short update
  [ "$status" -eq 0 ]
  [ "$output" = "Bash-Snippets is already the latest version" ]
fi
}

@test "The -h option should print usage" {
  run short -h
  [ "$status" -eq 0 ]
  [ "${lines[0]}" = "Short" ]
}

@test "No arguments prints usage instructions" {
  run short
  [ "$status" -eq 0 ]
  [ "${lines[0]}" = "Short" ]
}

@test "Get the tools version with -v" {
  run short -v
  [ "$status" -eq 0 ]
  result=$( echo $(short -v) | grep -Eo "Version")
  [ "$result" = "Version" ]
}
