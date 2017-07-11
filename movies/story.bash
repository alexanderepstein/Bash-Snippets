#!/bin/bash
params=$(config params)

if test "${params}"; then
  bash $story_dir/movies $params
else
  bash $story_dir/movies $cli_args
fi


