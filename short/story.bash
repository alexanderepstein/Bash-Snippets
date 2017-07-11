#!/bin/bash
params=$(config params)

if test "${params}"; then
  bash $story_dir/short $params
else
  bash $story_dir/short $cli_args
fi


