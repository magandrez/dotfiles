if status is-interactive; and set -q nvm_current_version; and not command -q node
    set -e nvm_current_version
end
