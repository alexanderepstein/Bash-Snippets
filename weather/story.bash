#!/bin/bash
params=$(config params)

if test "${params}"; then
  bash $story_dir/weather $params
else
  bash $story_dir/weather $cli_args
fi


