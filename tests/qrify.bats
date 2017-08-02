#!/bin/env bats

@test "Testing qrify tool" {
   echo qrify
}

@test "Check for latest version of bash-snippets on update" {
  if [[ "$(uname)" == "Linux" ]];then
  run qrify update
  [ "$status" -eq 0 ]
  [ "$output" = "Bash-Snippets is already the latest version" ]
fi
}

@test "The -h option should print usage" {
  run qrify -h
  [ "$status" -eq 0 ]
  [ "${lines[0]}" = "Qrify" ]
}

@test "Getting the qr code for a test string" {
  run qrify this is a test string
  [ "$status" -eq 0 ]
  [ "${lines[0]}" = "█████████████████████████████████" ]
  [ "${lines[1]}" = "█████████████████████████████████" ]
  [ "${lines[2]}" = "████ ▄▄▄▄▄ ██▀▄████ ██ ▄▄▄▄▄ ████" ]
  [ "${lines[3]}" = "████ █   █ █▄▀█▄▀█ ▀▀█ █   █ ████" ]
  [ "${lines[4]}" = "████ █▄▄▄█ ██▄▀▀  ▄ ▀█ █▄▄▄█ ████" ]
}





@test "No arguments prints usage instructions" {
  run qrify
  [ "$status" -eq 0 ]
  [ "${lines[0]}" = "Qrify" ]
}

@test "Get the tools version with -v" {
  run qrify -v
  [ "$status" -eq 0 ]
  result=$( echo $(qrify -v) | grep -Eo "Version")
  [ "$result" = "Version" ]
}
