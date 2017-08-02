#!/bin/env bats

@test "Testing currency tool" {
   echo currency
}

@test "Check for latest version of bash-snippets on update" {
  if [[ "$(uname)" == "Linux" ]];then
  run currency update
  [ "$status" -eq 0 ]
  [ "$output" = "Bash-Snippets is already the latest version" ]
fi
}

@test "The -h option should print usage" {
  run currency -h
  [ "$status" -eq 0 ]
  [ "${lines[0]}" = "Currency" ]
}

@test "Testing currency exchange (12.35 EUR TO USD)" {
  run currency EUR USD 12.35
  [ "$status" -eq 0 ]
  [ "${lines[0]}" = "=========================" ]
  [ "${lines[1]}" = "| EUR to USD" ]
  [ "${lines[3]}" = "| EUR: 12.35" ]
}

@test "Get the tools version with -v" {
  run currency -v
  [ "$status" -eq 0 ]
  result=$( echo $(currency -v) | grep -Eo "Version")
  [ "$result" = "Version" ]
}
