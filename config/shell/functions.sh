
###############################################################################
# Functions
###############################################################################

# These should mostly be separated out into separate files for each
# func. Some could also be scripts. Mostly these should be functions
# if they affect the environment in some way.

# Tar conveniences 
tarc() { tar czvf $1.tar.gz $1; }
tarx() { tar xzvf $1; }
tart() { tar tzvf $1; }
###############################################################################

