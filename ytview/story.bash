#!/bin/bash
params=$(config params)

if test "${params}"; then
  bash $story_dir/ytview $params
else
  bash $story_dir/ytview $cli_args
fi


