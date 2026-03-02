#!/usr/bin/env bash

srun -n 4 --gpus-per-task 1 --cpus-per-task 1 fom_job.middle.sh gpu &
srun -n 8 --cpus-per-task 1 fom_job.middle.sh cpu &

wait; exit
