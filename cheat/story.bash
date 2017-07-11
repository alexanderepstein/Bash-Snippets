#!/bin/bash
params=$(config params)

if test "${params}"; then
  bash $story_dir/cheat $params
else
  bash $story_dir/cheat $cli_args
fi


