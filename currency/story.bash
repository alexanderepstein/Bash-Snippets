#!/bin/bash
params=$(config params)

if test "${params}"; then
  bash $story_dir/currency $params
else
  bash $story_dir/currency $cli_args
fi


