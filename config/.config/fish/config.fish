# Load RVM
# rvm default
# load_nvm > /dev/stderr

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/usr/local/bin/gcloud/path.fish.inc' ]; . '/usr/local/bin/gcloud/path.fish.inc'; end
direnv hook fish | source