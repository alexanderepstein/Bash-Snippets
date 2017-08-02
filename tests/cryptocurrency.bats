#!/bin/env bats

@test "Testing cryptocurrency tool" {
   echo cryptocurrency
}

@test "Check for latest version of bash-snippets on update" {
  if [[ "$(uname)" == "Linux" ]];then
  run cryptocurrency update
  [ "$status" -eq 0 ]
  [ "$output" = "Bash-Snippets is already the latest version" ]
fi
}

@test "The -h option should print usage" {
  run cryptocurrency -h
  [ "$status" -eq 0 ]
  [ "${lines[0]}" = "CryptoCurrency" ]
}

@test "Testing cryptocurrency exchange (12.35 BTC TO USD)" {
  run cryptocurrency BTC USD 12.35
  [ "$status" -eq 0 ]
  [ "${lines[0]}" = "=========================" ]
  [ "${lines[3]}" = "| BTC: 12.35" ]
}

@test "Get the tools version with -v" {
  run cryptocurrency -v
  [ "$status" -eq 0 ]
  result=$( echo $(cryptocurrency -v) | grep -Eo "Version")
  [ "$result" = "Version" ]
}
