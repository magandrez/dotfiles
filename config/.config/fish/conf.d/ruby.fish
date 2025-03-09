set -gx GEM_HOME (ruby -e 'puts Gem.user_dir')/bin; contains $GEM_HOME $PATH; or set -gx PATH $GEM_HOME $PATH
