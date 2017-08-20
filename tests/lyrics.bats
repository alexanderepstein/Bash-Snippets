#!/bin/env bats

@test "Testing lyrics tool" {
   echo lyrics
}

@test "Check for latest version of bash-snippets on update" {
  if [[ "$(uname)" == "Linux" ]];then
  run lyrics update
  [ "$status" -eq 0 ]
  [ "$output" = "Bash-Snippets is already the latest version" ]
fi
}

@test "The -h option should print usage" {
  run lyrics -h
  [ "$status" -eq 0 ]
  [ "${lines[0]}" = "Lyrics" ]
}

@test "No arguments prints usage instructions" {
  run lyrics
  [ "$status" -eq 0 ]
  [ "${lines[0]}" = "Lyrics" ]
}

@test "Getting some lyrics" {
  run lyrics -a logic -s run it
  [ "$status" -eq 0 ]
  [ "${lines[0]}" = "Me and my team gotta intervene" ]
}

@test "Getting some lyrics to file" {
  rm -f ~/templyrics.txt
  run lyrics -a logic -s run it -f ~/templyrics.txt
  [ "$status" -eq 0 ]
  [ "$(cat $HOME/templyrics.txt | grep -Eo "Me and my team gotta intervene")" = "Me and my team gotta intervene" ]
  rm -f ~/templyrics.txt
}
