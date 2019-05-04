#!/usr/bin/env bats
export TOOL_NAME='bak2dvd'

setup() {
  # $REPO_DIR/tests/skeleton.bats
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

@test "Change into the tool directory for ${TOOL_NAME}" {
  cd "${TOOL_DIR}" && pwd
  [[ "$status" -eq 0 ]]
}

@test "Check for latest version of bash-snippets on update" {
  if [[ "$(uname)" == "Linux" ]]; then
    run "${TOOL_DIR}/${TOOL_NAME}" update
    [[ "$status" -eq 0 ]]
    [[ "$output" = "Bash-Snippets is already the latest version" ]]
  fi
}

@test "No arguments prints usage instructions" {
  run "${TOOL_DIR}/${TOOL_NAME}"
  [[ "$status" -eq 0 ]]
  [[ "${lines[0]}" = "${TOOL_NAME^}" ]]
}

@test "The -h option should print usage" {
  run "${TOOL_DIR}/${TOOL_NAME}" -h
  [[ "$status" -eq 0 ]]
  [[ "${lines[0]}" = "${TOOL_NAME^}" ]]
}

@test "Get the tools version with -v" {
  run "${TOOL_DIR}/${TOOL_NAME}" -v
  [[ "$status" -eq 0 ]]
  [[ "printf '%s\n' ${lines[0]}" =~ 'Version' ]]
}

# Tool specific tests
