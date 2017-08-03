#!/bin/env bats

@test "Testing transfer tool" {
   echo transfer
}

@test "Check for latest version of bash-snippets on update" {
  if [[ "$(uname)" == "Linux" ]];then
  run transfer update
  [ "$status" -eq 0 ]
  [ "$output" = "Bash-Snippets is already the latest version" ]
fi
}

@test "The -h option should print usage" {
  run transfer -h
  [ "$status" -eq 0 ]
  [ "${lines[0]}" = "Transfer" ]
}

@test "Testing file upload" {
  touch testFile.txt
  echo -n "This is some example content." > $(pwd)/testFile.txt
  run transfer -s testFile.txt
  transferResponse=$(transfer -s testFile.txt)
  rm -f $(pwd)/testFile.txt
  transferCommand=$( echo $transferResponse | cut -d $'\n' -f 3 | sed s/"Transfer Download Command:"//g | sed s:"desiredOutputDirectory":"$HOME":g | sed s:"^ "::g)
  transferStatus=$( echo $transferResponse | grep -Eo "Success!")
  [ "$status" -eq 0 ]
  [ "$transferStatus" = "Success!" ] ## this works for darwin but the test wont

}


#@test "Testing file download" {
#  rm -f $HOME/testFile.txt
#  run $(echo $transferCommand)

#  contents=$(cat $HOME/testFile.txt)
#  rm -f $HOME/testFile.txt
#  if [[ $contents != "This is some example content." ]];then exit 1; fi
#}

@test "Get the tools version with -v" {
  run transfer -v
  [ "$status" -eq 0 ]
  result=$( echo $(transfer -v) | grep -Eo "Version")
  [ "$result" = "Version" ]
}
