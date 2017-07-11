#!/bin/bash
params=$(config params)

if test "${params}"; then
  bash $story_dir/cloudup $params
else
  bash $story_dir/cloudup $cli_args
fi


