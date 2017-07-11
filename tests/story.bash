#!/bin/bash
params=$(config params)

if test "${params}"; then
  bash $story_dir/tests $params
else
  bash $story_dir/tests $cli_args
fi


