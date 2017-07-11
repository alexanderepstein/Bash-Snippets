#!/bin/bash
params=$(config params)

if test "${params}"; then
  bash $story_dir/stocks $params
else
  bash $story_dir/stocks $cli_args
fi


