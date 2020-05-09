#!/usr/bin/env bats

export TOOL_NAME='gist'
export GIST_USER='phamhsieh'
export GIST_API_TOKEN='dd43dc9949a5b4a1d6c7''b779f13af357282016e4'

setup() {
  # $REPO_DIR/tests/taste.bats
  REPO_DIR="$( cd "$( dirname "${BATS_TEST_DIRNAME}")" >/dev/null 2>&1 && pwd)"
  TOOL_DIR="$( cd "${REPO_DIR}/${TOOL_NAME}" >/dev/null 2>&1 && pwd)"
}

@test "Testing ${TOOL_NAME} tool" {
  echo "${TOOL_NAME}"
}

@test "Get the tools version with command version" {
  run "${TOOL_DIR}/${TOOL_NAME}" version
  [ "$status" -eq 0 ]
  result=$( echo $(${TOOL_DIR}/${TOOL_NAME} version) | grep -Eo "Version")
  [ "$result" = "Version" ]
}

@test "Check for latest version of bash-snippets on update" {
  if [[ "$(uname)" == "Linux" ]]; then
    run "${TOOL_DIR}/${TOOL_NAME}" update

    [[ "$status" -eq 0 ]]
    [ "$output" == "Bash-Snippets is already the latest version" ]
  fi
}

@test "The help command should print usage" {
  run "${TOOL_DIR}/${TOOL_NAME}" help

  [[ "$status" -eq 0 ]]
  [[ "${lines[0]}" = "${TOOL_NAME}" ]]
}

@test "Use config command to add configuarion for user" {
  run "${TOOL_DIR}/${TOOL_NAME}" config user ${GIST_USER}
  [ "$status" -eq 0 ]
  [ "${lines[-1]}" = "user=${GIST_USER}" ]
}

@test "Use config command to add configuarion for token" {
  run "${TOOL_DIR}/${TOOL_NAME}" config token ${GIST_API_TOKEN}
  [ "$status" -eq 0 ]
  [ "${lines[-1]}" = "token=${GIST_API_TOKEN}" ]
}

@test "The new command should create a new public gist with gist command" {
  hint=false run "${TOOL_DIR}/${TOOL_NAME}" new --file gist --desc 'Manage gist like a pro' "${TOOL_DIR}/${TOOL_NAME}"
  [ "$status" -eq 0 ]
  [[ "${lines[-1]}" =~ ([0-9]+ +https://gist.github.com/[0-9a-z]+) ]]
}

@test "The fetch command should fetch user gists" {
  hint=false run "${TOOL_DIR}/${TOOL_NAME}" fetch
  [ "$status" -eq 0 ]
  [[ "${lines[-1]}" =~ ([0-9]+ +https://gist.github.com/[0-9a-z]+) ]]
}

@test "The fetch command should fetch starred gists" {
  hint=false run "${TOOL_DIR}/${TOOL_NAME}" fetch star
  [ "$status" -eq 0 ]
  echo ${lines[-1]}
  [[ "${lines[-1]}" =~ (Not a single valid gist|^ *s[0-9]+ +https://gist.github.com/[0-9a-z]+) ]]
}

@test "No arguments prints the list of gists" {
  hint=false run "${TOOL_DIR}/${TOOL_NAME}"
  [ "$status" -eq 0 ]
  [[ "${lines[-1]}" =~ ([0-9]+ +https://gist.github.com/[0-9a-z]+) ]]
}

@test "Specify an index to return the path of cloned repo" {
  run "${TOOL_DIR}/${TOOL_NAME}" 1 --no-action
  [ "$status" -eq 0 ]
  [[ "${lines[-1]}" =~ (${HOME}/gist/[0-9a-z]+) ]]
}

@test "The edit command should modify the description of a gist" {
  "${TOOL_DIR}/${TOOL_NAME}" edit 1 "Modified description"
  run "${TOOL_DIR}/${TOOL_NAME}" detail 1
  [ "$status" -eq 0 ]
  [[ "${lines[0]}" =~ (Modified description$) ]]
}

@test "The delete command should delete specified gists" {
  run "${TOOL_DIR}/${TOOL_NAME}" delete 1 --force
  [ "$status" -eq 0 ]
  [ "${lines[0]}" = '1 deleted' ]
}

@test "The user command should get the list of public gists from a user" {
  run "${TOOL_DIR}/${TOOL_NAME}" user defunkt
  [ "$status" -eq 0 ]
  [[ "${lines[0]}" =~ (https://gist.github.com/[0-9a-z]+ defunkt) ]]
}
