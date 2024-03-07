
tf_log_level=${1:-ERROR}

echo $1

# TEST_ALL=${1:false}
# Set TF_LOG to DEBUG
export TF_LOG=$tf_log_level
echo $TF_LOG
echo "TF_LOG = $TF_LOG"
# Unset TF_LOG after you're done
unset TF_LOG

echo "TF_LOG = $TF_LOG"