#!/usr/bin/env bats

@test "Testing gist tool" {
   echo gist
}

@test "Check for latest version of bash-snippets on update" {
  if [[ "$(uname)" == "Linux" ]];then
      run gist update
      [ "$status" -eq 0 ]
      [ "$output" = "Bash-Snippets is already the latest version" ]
  fi
}

@test "Adding configuarion for user" {
  run gist config user defunkt
  [ "$status" -eq 0 ]
  [ "${lines[-1]}" = "user=defunkt" ]
}

@test "No arguments prints the list of gists" {
  hint=false run gist
  echo "status = ${status}"
  echo "output = ${output}"
  [ "$status" -eq 0 ]
}

@test "The help option should print usage" {
  run gist help
  [ "$status" -eq 0 ]
  [ "${lines[0]}" = "gist" ]
}

@test "Get the list of gists from user defunkt" {
  run gist user defunkt
  [ "$status" -eq 0 ]
  [ "${lines[0]}" = "https://gist.github.com/406608 2 6 defunkt My Ruby Setup" ]
}

@test "Get the tools version with -v" {
  run gist version
  [ "$status" -eq 0 ]
  result=$( echo $(todo -v) | grep -Eo "Version")
  [ "$result" = "Version" ]
}
