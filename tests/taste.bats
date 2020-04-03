#!/usr/bin/env bats

export TOOL_NAME='taste'
export TASTE_API_KEY="290044-Taste-QIQUQKOZ"

setup() {
  # $REPO_DIR/tests/taste.bats
  REPO_DIR="$( cd "$( dirname "${BATS_TEST_DIRNAME}")" >/dev/null 2>&1 && pwd)"
  TOOL_DIR="$( cd "${REPO_DIR}/${TOOL_NAME}" >/dev/null 2>&1 && pwd)"
}

@test "Testing ${TOOL_NAME} tool" {
  echo "${TOOL_NAME}"
}

@test "Check for latest version of bash-snippets on update" {
  if [[ "$(uname)" == "Linux" ]]; then
    run "${TOOL_DIR}/${TOOL_NAME}" update

    [[ "$status" -eq 0 ]]
    [ "$output" == "Bash-Snippets is already the latest version" ]
  fi
}

@test "The -h option should print usage" {
  run "${TOOL_DIR}/${TOOL_NAME}" -h

  [[ "$status" -eq 0 ]]
  # if bash is less than 7 yrs old
  if ((${BASH_VERSINFO[0]} >= 4)); then
    [[ "${lines[0]}" = "${TOOL_NAME^}" ]]
  else
    # or im probably a stoneage mac
    [[ "$(echo "${output}" | grep -i "${TOOL_NAME}")" ]]
  fi
}

@test "No arguments prints usage instructions" {
  run "${TOOL_DIR}/${TOOL_NAME}"

  [[ "$status" -eq 0 ]]
  # if bash is less than 7 yrs old
  if ((${BASH_VERSINFO[0]} >= 4)); then
    [[ "${lines[0]}" = "${TOOL_NAME^}" ]]
  else
    # or im probably a stoneage mac
    [[ "$(echo "${output}" | grep -i "${TOOL_NAME}")" ]]
  fi
}

@test "Get the tools version with -v" {
  run "${TOOL_DIR}/${TOOL_NAME}" -v

  [[ "$status" -eq 0 ]]
  expected='Version'
  [[ "${output}" =~ "${expected}" ]]
}

@test "Testing short recommendations" {
  run "${TOOL_DIR}/${TOOL_NAME}" 50 Cent

  # order of ouput lines changed
  [[ "$status" -eq 0 ]]
  expected='(G-Unit|The Game|Lloyd Banks): .+'
  [ "${lines[0]}" = "===================================" ]
  [[ "${lines[1]}" =~ ${expected} ]]
  [[ "${lines[2]}" =~ ${expected} ]]
  [[ "${lines[3]}" =~ ${expected} ]]
  [ "${lines[4]}" = "===================================" ]
}

@test "Testing long recommendations" {
  run "${TOOL_DIR}/${TOOL_NAME}" -i Sublime

  [[ "$status" -eq 0 ]]
  expected='Soundsystem is the fifth studio album by 311, released on October 12, 1999. Soundsystem, which was certified Gold by the RIAA,'
  [[ "${output}" =~ "${expected}" ]]
}

@test "Testing search on item" {
  run "${TOOL_DIR}/${TOOL_NAME}" -s Kendrick Lamar

  [[ "$status" -eq 0 ]]
  expected='Kendrick Lamar Duckworth'
  [[ "${output}" =~ "${expected}" ]]
}

