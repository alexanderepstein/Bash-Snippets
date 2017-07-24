#!/usr/bin/env bash

declare -a tools=$(config tools)


for t in "${tools[@]}"; do
   run_story $t
done

