#!/bin/bash
params=$(config params)

if test "${params}"; then
  bash $story_dir/taste $params
else
  bash $story_dir/taste $cli_args
fi


