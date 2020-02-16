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

@test "Get the tools version with version" {
  run gist version
  [ "$status" -eq 0 ]
  result=$( echo $(todo -v) | grep -Eo "Version")
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
  run gist config user ${GIST_USER}
  [ "$status" -eq 0 ]
  [ "${lines[-1]}" = "user='${GIST_USER}'" ]
}

@test "Use config command to add configuarion for token" {
  run gist config token ${GIST_API_TOKEN}
  [ "$status" -eq 0 ]
  [ "${lines[-1]}" = "token='${GIST_API_TOKEN}'" ]
}

@test "The new command should create a new public gist " {
  echo bar > foo
  hint=false run gist new foo -d 'new gist'
  [ "$status" -eq 0 ]
  [[ "${lines[-1]}" =~ (^ *[0-9]+ https://gist.github.com/[[:alnum:]]+) ]]
}

@test "The fetch command should fetch user gists" {
  hint=false run gist fetch
  [ "$status" -eq 0 ]
  [[ "${lines[-1]}" =~ (^ *[0-9]+ https://gist.github.com/[[:alnum:]]+) ]]
}

@test "The fetch command should fetch starred gists" {
  hint=false run gist fetch star
  [ "$status" -eq 0 ]
  [[ "${lines[-1]}" =~ (List is empty|^ *s[0-9]+ https://gist.github.com/[[:alnum:]]+) ]]
}

@test "No arguments prints the list of gists" {
  hint=false run gist
  [ "$status" -eq 0 ]
  [[ "${lines[-1]}" =~ (^ *[0-9]+ https://gist.github.com/[[:alnum:]]+) ]]
}

@test "Specify an index to return the path of cloned repo" {
  run gist 1 --no-action
  echo ${lines[0]}
  [ "$status" -eq 0 ]
  [[ "${lines[0]}" =~ (${HOME}/gist/[[:alnum:]]+) ]]
}

@test "The edit command should modify the description of a gist" {
  run gist edit 1 "Modified description"
  [ "$status" -eq 0 ]
  [[ "${lines[0]}" =~ (Modified description$) ]]
}

@test "The delete command should delete specified gists" {
  confirm=false run gist delete 1
  [ "$status" -eq 0 ]
  [ "${lines[0]}" = '1 deleted' ]
}

@test "The user command should get the list of public gists from a user" {
  run gist user defunkt
  [ "$status" -eq 0 ]
  [ "${lines[0]}" = "https://gist.github.com/406608 2 6 defunkt My Ruby Setup" ]
}
