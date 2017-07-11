#!/bin/bash
params=$(config params)

if test "${params}"; then
  bash $story_dir/crypt $params
else
  bash $story_dir/crypt $cli_args
fi


