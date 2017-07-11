#!/bin/bash
params=$(config params)

if test "${params}"; then
  bash $story_dir/qrify $params
else
  bash $story_dir/qrify $cli_args
fi


