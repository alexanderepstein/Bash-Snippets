#!/usr/bin/env bats

export TOOL_NAME='short'

setup() {
  # $REPO_DIR/tests/short.bats
  REPO_DIR="$( cd "$( dirname "${BATS_TEST_DIRNAME}")" >/dev/null 2>&1 && pwd)"
  TOOL_DIR="$( cd "${REPO_DIR}/${TOOL_NAME}" >/dev/null 2>&1 && pwd)"
}

@test "Testing ${TOOL_NAME} tool" {
  echo "${TOOL_NAME}"
}

@test "Confirm the \$REPO_DIR variable is evaluated" {
  cd "${REPO_DIR}" && pwd
  
  [[ "$status" -eq 0 ]]
}

# can cd into script dir
@test "Confirm a valid directory for ${TOOL_NAME}" {
  cd "${TOOL_DIR}" && pwd
  
  [[ "$status" -eq 0 ]]
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

# Tool specific tests

@test "Shorten github repo URL" {
  longurl='https://github.com/alexanderepstein/Bash-Snippets'
  run "${TOOL_DIR}/${TOOL_NAME}" -s "${longurl}"
  
  [[ "$status" -eq 0 ]]
  expected='http://tinyurl.com/.+'
  [[ "${lines[2]}" =~ (${expected}) ]]
}

@test "Expand tinyurl URL" {
  shorturl='http://tinyurl.com/uowfbb5'
  run "${TOOL_DIR}/${TOOL_NAME}" -e "${shorturl}"
  
  [[ "$status" -eq 0 ]]
  expected='https://github.com/alexanderepstein/Bash-Snippets'
  [[ "${lines[2]}" =~ "${expected}" ]]
}

