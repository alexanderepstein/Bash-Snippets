#!/bin/bash
params=$(config params)

if test "${params}"; then
  bash $story_dir/geo $params
else
  bash $story_dir/geo $cli_args
fi


