#!/bin/bash 

################################################################################
# Run the model for as long as we can, then prepare for a restart and submit the next job.
################################################################################

#SBATCH --partition=cpu
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=1
#SBATCH --time=00:30:00
#SBATCH --mem=16G   #memory per node
##SBATCH --job-name=MIS_$JOBNO
##SBATCH --account=$HECACC
#SBATCH --chdir=../run
#SBATCH --no-requeue


# pass the julia depot path through singularity
export JULIA_DEPOT_PATH="/opt/julia"
#export SINGULARITYENV_JULIA_DEPOT_PATH="/opt/julia"

function hmsleft()
{
        local lhms
        lhms=$(squeue  -j $SLURM_JOB_ID -O TimeLeft | tail -1)
        echo $lhms
}
function secsleft() {
    if [[ ${#hms} < 6 ]]
    then
        echo secs=$(echo $hms|awk -F: '{print ($1 * 60) + $2 }')
    else
        echo secs=$(echo $hms|awk -F: '{print ($1 * 3600) + ($2 * 60) + $3 }')
    fi
}

# start timer
timeqend="$(date +%s)"
elapsedqueue="$(expr $timeqend - $TIMEQSTART)"
timestart="$(date +%s)"
echo >> times
echo Queue-time seconds $elapsedqueue >> times
echo Run start `date` >> times
hms=$(hmsleft)
echo Walltime left is $hms>>walltime
rem_secs=$(secsleft)  # function above
echo Walltime left in seconds is $rem_secs >> walltime
# Subtract 3 minutes
RUNTIME="$(($rem_secs-180))"
echo Will run for $RUNTIME sec >> walltime


echo "received from SLURM"  IMGNAME=$IMGNAME,JDEPOT=$JDEPOT,JOBNO=$JOBNO,TIMEQSTART=$TIMEQSTART

timeout $RUNTIME singularity exec -B ${JDEPOT}:/opt/julia ${IMGNAME} julia driver.jl

