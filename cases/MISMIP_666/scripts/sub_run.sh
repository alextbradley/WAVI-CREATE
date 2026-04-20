#!/bin/bash

# clean run directory and link all required files
./prep_run.sh

# set job id
JOBNO=666

# record start times
TIMEQSTART="$(date +%s)"
echo Start-time `date` >> times


# submit the job
sbatch -J MIS_$JOBNO \
       --export TIMEQSTART=$TIMEQSTART,IMGNAME=$IMGPATH,JDEPOT=$JDEPOT,JOBNO=$JOBNO \
       ./run_repeat.sh

# to add charging account (with HECACC set as variable in bashrc)
#       -A $HECACC \
#       --export HECACC=$HECACC,TIMEQSTART=$TIMEQSTART,IMGNAME=$IMGNAME,JDEPOT=$JDEPOT,JOBNO=$JOBNO,TIMEQSTART=$TIMEQSTART \
