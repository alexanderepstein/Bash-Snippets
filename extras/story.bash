#!/bin/bash
params=$(config params)

if test "${params}"; then
  bash $story_dir/extras $params
else
  bash $story_dir/extras $cli_args
fi


