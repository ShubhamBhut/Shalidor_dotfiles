if status is-interactive
    # Commands to run in interactive sessions can go here
end
set -gx PATH /home/KaiLorston/.local/bin:/sbin:/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/usr/bin/site_perl:/usr/bin/vendor_perl:/usr/bin/core_perl /home/KaiLorston/.foundry/bin
set -gx GEMINI_API_KEY "AIzaSyACdmWQoWEUC_RQIKsYleru1ZcAB_epd1A"

# Haskell / GHCup Paths
set -gx PATH $HOME/.ghcup/bin $HOME/.cabal/bin $PATH

zoxide init fish | source

# Override `cd` to use `z` (with fallback to regular `cd`)
function cd
    if count $argv > /dev/null
        z $argv
    else
        z ~
    end
end

# Added by LM Studio CLI (lms)
set -gx PATH $PATH /home/KaiLorston/.lmstudio/bin
# End of LM Studio CLI section

