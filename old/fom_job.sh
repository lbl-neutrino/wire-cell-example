#!/usr/bin/env bash

srun -K0 -n 4 --gpus-per-task 1 --cpus-per-task 1 fom_job.middle.sh gpu &
srun -K0 -n 8 --cpus-per-task 1 fom_job.middle.sh cpu &

wait; exit
