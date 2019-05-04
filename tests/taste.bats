#!/usr/bin/env bats

export TOOL_NAME='taste'
export TASTE_API_KEY="290044-Taste-QIQUQKOZ"

setup() {
  # $REPO_DIR/tests/skeleton.bats
  REPO_DIR="$( cd "$( dirname "${BATS_TEST_DIRNAME}")" >/dev/null 2>&1 && pwd)"
  TOOL_DIR="$( cd "${REPO_DIR}/${TOOL_NAME}" >/dev/null 2>&1 && pwd)"
}

@test "Testing ${TOOL_NAME} tool" {
  echo "${TOOL_NAME}"
}


@test "The -h option should print usage" {
#  if [[ "$(uname)" == "Darwin" ]]; then
   run "${TOOL_DIR}/${TOOL_NAME}" -h
  [ "$status" -eq 0 ]
  [ "${lines[0]}" = "${TOOL_NAME^}" ]
#  fi
}

@test "Testing short recommendations" {
  #if [[ "$(uname)" == "Darwin" ]]; then
  run "${TOOL_DIR}/${TOOL_NAME}" 50 Cent
  [ "$status" -eq 0 ]
  [ "${lines[0]}" = "===================================" ]
  [ "${lines[1]}" = "G-Unit: music" ]
  [ "${lines[2]}" = "The Game: music" ]
  [ "${lines[3]}" = "Lloyd Banks: music" ]
  [ "${lines[4]}" = "===================================" ]
  #fi
}

@test "Testing long recommendations" {
  #if [[ "$(uname)" == "Darwin" ]]; then
  run "${TOOL_DIR}/${TOOL_NAME}" -i Sublime
  [ "$status" -eq 0 ]
  expected='Soundsystem is the fifth studio album by 311, released on October 12, 1999. Soundsystem, which was certified Gold by the RIAA,'
  [[ "${output}" =~ "${expected}" ]]
  #fi
}

@test "Testing search on item" {
  #if [[ "$(uname)" == "Darwin" ]]; then
  run "${TOOL_DIR}/${TOOL_NAME}" -s Kendrick Lamar
  [ "$status" -eq 0 ]
  expected='Kendrick Lamar Duckworth'
  [[ "${output}" =~ "${expected}" ]]
  #[ "$response" = "Kendrick Lamar Duckworth" ]
  #fi
}

@test "No arguments prints usage instructions" {
 # if [[ "$(uname)" == "Darwin" ]]; then
  #run taste
  run "${TOOL_DIR}/${TOOL_NAME}"
  [ "$status" -eq 0 ]
  [ "${lines[0]}" = "${TOOL_NAME^}" ]
  #[ "${lines[0]}" = "Taste" ]
#fi
}

@test "Get the tools version with -v" {
  #if [[ "$(uname)" == "Darwin" ]]; then
  run "${TOOL_DIR}/${TOOL_NAME}" -v
  [ "$status" -eq 0 ]
  expected='Version'
  [[ "${output}" =~ "${expected}" ]]
  #fi
}
