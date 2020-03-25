###############################################################################
# Functions
#
# My personal functions to make life happier
###############################################################################

aws_sso() {
    export AWS_PROFILE="$1"
    aws sso login --profile "$1"
}