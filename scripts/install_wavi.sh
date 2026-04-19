# Script to install wavi 

#
# choose install location (!! This will overwrite anything you have in this depot, be careful !!)
# # Script to install wavi 
#
#
# choose install location (!! This will overwrite anything you have in this depot, be careful !!)
#
#
INSTALL_LOC=$W_ROOT/.julia
rm -rf $INSTALL_LOC
mkdir $INSTALL_LOC
echo "About to start installing wavi in $INSTALL_LOC"

export SINGULARITYENV_JULIA_DEPOT_PATH="/opt/julia"
singularity exec -B $INSTALL_LOC:/opt/julia,$(pwd) $IMGPATH julia julia_install_wavi.jl
rm julia_install_wavi.jl
echo "returning to $W_ROOT/scripts..."
cd $W_ROOT/scripts/
