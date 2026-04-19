# Script to install wavi 

#
# choose install location (!! This will overwrite anything you have in this depot, be careful !!)
# # Script to install wavi. Need to first launch and interactive compute node session with at least 16gb memory: srun -p cpu --time 120 --mem=64000 --pty /bin/bash  (this example has 64gb)
#
#
# choose install location (!! This will overwrite anything you have in this depot, be careful !!)
#
#
INSTALL_LOC=$W_ROOT/.julia
rm -rf $INSTALL_LOC
mkdir $INSTALL_LOC
echo "About to start installing wavi in $INSTALL_LOC"

export JULIA_DEPOT_PATH="/opt/julia"
export JULIA_NUM_PRECOMPILE_TASKS=1
export JULIA_CPU_THREADS=1

singularity exec -B $INSTALL_LOC:/opt/julia,$(pwd) $IMGPATH julia julia_install_wavi.jl
