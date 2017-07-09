#!/bin/env bats

@test "Testing taste tool" {
   echo taste
   export TASTE_API_KEY="275041-BashSnip-KQ51U8H8" >> ~/.bash_profile

}

@test "Check for latest version of bash-snippets on update" {
  run taste update
  [ "$status" -eq 0 ]
  [ "$output" = "Bash-Snippets is already the latest version" ]
}

@test "The -h option should print usage" {
  run taste -h
  [ "$status" -eq 0 ]
  [ "${lines[0]}" = "Taste" ]
}

@test "Testing short recommendations" {
  run taste Kid Cudi
  [ "$status" -eq 0 ]
  [ "${lines[0]}" = "===================================" ]
  [ "${lines[1]}" = "Lupe Fiasco: music" ]
  [ "${lines[2]}" = "Shadows And Fog: movie" ]
  [ "${lines[3]}" = "Lulu James: music" ]
  [ "${lines[4]}" = "===================================" ]
}

@test "Testing long recommendations" {
  run taste -i Sublime
  [ "$status" -eq 0 ]
  response=$(echo $(taste -i Sublime) | grep -Eo "Soundsystem is the fifth studio album by 311, released on October 12, 1999. Soundsystem, which was certified Gold by the RIAA,")
  [ "$response" = "Soundsystem is the fifth studio album by 311, released on October 12, 1999. Soundsystem, which was certified Gold by the RIAA," ]
}

@test "Testing search on item" {
  run taste -s Kendrick Lamar
  [ "$status" -eq 0 ]
  response=$(echo $(taste -s Kendrick Lamar) | grep -Eo "Kendrick Lamar Duckworth \(born June 17, 1987\) is an American rapper and songwriter.")
  [ "$response" = "Kendrick Lamar Duckworth (born June 17, 1987) is an American rapper and songwriter." ]
}

@test "No arguments prints usage instructions" {
  run taste
  [ "$status" -eq 0 ]
  [ "${lines[0]}" = "Taste" ]
}

@test "Get the tools version with -v" {
  run taste -v
  [ "$status" -eq 0 ]
  result=$( echo $(taste -v) | grep -Eo "Version")
  [ "$result" = "Version" ]
}
