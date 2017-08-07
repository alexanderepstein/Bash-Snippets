#!/bin/env bats

@test "Testing taste tool" {
   echo taste
   export TASTE_API_KEY="275041-BashSnip-KQ51U8H8" >> ~/.bash_profile

}


@test "The -h option should print usage" {
  if [[ "$(uname)" == "Darwin" ]]; then
  run taste -h
  [ "$status" -eq 0 ]
  [ "${lines[0]}" = "Taste" ]
 fi
}

@test "Testing short recommendations" {
  if [[ "$(uname)" == "Darwin" ]]; then
  run taste 50 Cent
  [ "$status" -eq 0 ]
  [ "${lines[0]}" = "===================================" ]
  [ "${lines[1]}" = "G-Unit: music" ]
  [ "${lines[2]}" = "Lloyd Banks: music" ]
  [ "${lines[3]}" = "The Game: music" ]
  [ "${lines[4]}" = "===================================" ]
 fi
}

@test "Testing long recommendations" {
  if [[ "$(uname)" == "Darwin" ]]; then
  run taste -i Sublime
  [ "$status" -eq 0 ]
  response=$(echo $(taste -i Sublime) | grep -Eo "Soundsystem is the fifth studio album by 311, released on October 12, 1999. Soundsystem, which was certified Gold by the RIAA,")
  [ "$response" = "Soundsystem is the fifth studio album by 311, released on October 12, 1999. Soundsystem, which was certified Gold by the RIAA," ]
fi
}

@test "Testing search on item" {
  if [[ "$(uname)" == "Darwin" ]]; then
  run taste -s Kendrick Lamar
  [ "$status" -eq 0 ]
  response=$(echo $(taste -s Kendrick Lamar) | grep -Eo "Kendrick Lamar Duckworth \(born June 17, 1987\) is an American rapper and songwriter.")
  [ "$response" = "Kendrick Lamar Duckworth (born June 17, 1987) is an American rapper and songwriter." ]
fi
}

@test "No arguments prints usage instructions" {
  if [[ "$(uname)" == "Darwin" ]]; then
  run taste
  [ "$status" -eq 0 ]
  [ "${lines[0]}" = "Taste" ]
fi
}

@test "Get the tools version with -v" {
  if [[ "$(uname)" == "Darwin" ]]; then
  run taste -v
  [ "$status" -eq 0 ]
  result=$( echo $(taste -v) | grep -Eo "Version")
  [ "$result" = "Version" ]
fi
}
