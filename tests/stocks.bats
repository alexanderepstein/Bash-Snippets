#!/usr/bin/env bats

@test "Testing stocks tool" {
   echo stocks
}

@test "The help command should print usage" {
  run stocks help
  [ "$status" -eq 0 ]
  [ "${lines[0]}" = "Stocks Usage" ]
}

@test "No arguments prints usage instructions" {
  run stocks
  [ "$status" -eq 1 ]
  [ "${lines[0]}" = "Stocks Usage" ]
}

@test "Get stock info by passing in ticker" {
  result=$( echo $(stocks AAPL) | grep -Eo "Apple, Inc. -- Stock Information" )
  [ "$result" = "Apple, Inc. -- Stock Information" ]

}

@test "Get stock info by passing in company" {
  result=$( echo $(stocks Apple) | grep -Eo "Apple, Inc. -- Stock Information" )
  [ "$result" = "Apple, Inc. -- Stock Information" ]
}

@test "Get the tools version" {
  run stocks version
  [ "$status" -eq 0 ]
  result=$( echo $(stocks version) | grep -Eo "Version")
  [ "$result" = "Version" ]
}
