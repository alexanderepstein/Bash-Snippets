#!/bin/env bats

@test "Testing todo tool" {
   echo todo
}

@test "Check for latest version of bash-snippets on update" {
  if [[ "$(uname)" == "Linux" ]];then
  run todo update
  [ "$status" -eq 0 ]
  [ "$output" = "Bash-Snippets is already the latest version" ]
fi
}


@test "No arguments prints usage instructions" {
  run todo
  [ "$status" -eq 0 ]
  [ "${lines[0]}" = "Todo" ]
}

@test "The -h option should print usage" {
  run todo -h
  [ "$status" -eq 0 ]
  [ "${lines[0]}" = "Todo" ]
}

@test "Adding task" {
  run todo -a First task ever
  [ "$status" -eq 0 ]
  result=$( echo $(todo -g) | grep -Eo "01\). First task ever" )
  [ "$result" = "01). First task ever" ]
}

@test "Getting task" {
  run todo -g
  [ "$status" -eq 0 ]
  result=$( echo $(todo -g) | grep -Eo "01\). First task ever" )
  [ "$result" = "01). First task ever" ]
}

@test "Removing task" {
  run todo -r "1"
  [ "$status" -eq 0 ]
  result=$( cat ~/.todo/list.txt )
  echo $result
  [ "$result" = "" ]
}

@test "Getting from empty task list" {
  run todo -g
  [ "$status" -eq 0 ]
  [ "$output" = "No tasks found" ]
}

@test "Get the tools version with -v" {
  run todo -v
  [ "$status" -eq 0 ]
  result=$( echo $(todo -v) | grep -Eo "Version")
  [ "$result" = "Version" ]
}
