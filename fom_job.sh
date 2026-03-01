#!/usr/bin/env bash

n=$(wc -l < fom_job.args.txt)

srun -n "$n" --gpus-per-task 1 --cpus-per-task 1 fom_job.middle.sh gpu &
srun -n "$n" --cpus-per-task 1 fom_job.middle.sh cpu &

wait
