# Inspired by https://codeberg.org/gpanders/dotfiles/src/branch/master/.config/fish/conf.d/prompt.fish
#
status is-interactive; or exit

function __prompt_update_pwd --on-variable PWD
    set -g __prompt_pwd (prompt_pwd)
    # Reset git dir so it can be rediscovered
    set -e __prompt_git_dir
end

function __prompt_venv --on-variable VIRTUAL_ENV --on-variable IN_NIX_SHELL
    if set -q VIRTUAL_ENV
        set -g __prompt_venv (basename $VIRTUAL_ENV)' '
    else if set -q IN_NIX_SHELL
        set -g __prompt_venv 'nix-shell '
    else
        set -g __prompt_venv
    end
end

function __prompt_update_git --on-variable __prompt_git_branch --on-variable __prompt_git_dirty --on-variable __prompt_git_upstream
    set -g __prompt_git "$__prompt_git_branch$__prompt_git_dirty$__prompt_git_upstream"
    commandline -f repaint
end

function __prompt_handler --on-event fish_prompt
    set -q __prompt_pwd; or __prompt_update_pwd

    # Git discovery
    if not set -q __prompt_git_dir
        if test -n "$GIT_DIR"
            set -g __prompt_git_dir "$GIT_DIR"
        else if test -d .git
            set -g __prompt_git_dir $PWD/.git
        else if test -f .git
            set -g __prompt_git_dir (string match -r -g '^gitdir: (.*)$' < .git)
        else
            set -g __prompt_git_dir (command git rev-parse --show-toplevel 2>/dev/null)
        end
    end

    # Git status
    if test -z "$__prompt_git_dir"
        set -g __prompt_git
    else
        set -l HEAD
        if test -f $__prompt_git_dir/HEAD
            set HEAD $__prompt_git_dir/HEAD
        else
            set HEAD (command git rev-parse --git-path HEAD 2>/dev/null)
        end

        # Get branch name
        set -g __prompt_git_branch (string match -r -g '^ref: refs/heads/(.*)|([0-9a-f]{8})[0-9a-f]+$' < $HEAD)

        # Async dirty check
        begin
            block -l
            fish -P -c "command git diff-index --no-ext-diff --quiet HEAD 2>/dev/null" &
            function __prompt_git_dirty_$last_pid --on-process-exit $last_pid
                functions -e __prompt_git_dirty_$last_pid
                set -l ret $argv[3]
                switch $ret
                    case 0
                        set -g __prompt_git_dirty ''
                    case '*'
                        set -g __prompt_git_dirty '*'
                end
            end
        end

        # Async upstream check
        begin
            block -l
            fish -P -c "
                set count (git rev-list --count --left-right @{u}...HEAD 2>/dev/null; or true)
                switch \"\$count\"
                    case '' '0'\t'0'
                        return 0
                    case '0'\t'*'
                        return 1
                    case '*'\t'0'
                        return 2
                    case '*'
                        return 3
                end
            " &
            function __prompt_git_upstream_$last_pid --on-process-exit $last_pid
                functions -e __prompt_git_upstream_$last_pid
                set -l ret $argv[3]
                switch $ret
                    case 0
                        set -g __prompt_git_upstream ''
                    case 1
                        set -g __prompt_git_upstream '>'
                    case 2
                        set -g __prompt_git_upstream '<'
                    case 3
                        set -g __prompt_git_upstream '<>'
                end
            end
        end
    end
end

function fish_prompt
    set -l git_info
    if set -q __prompt_git; and test -n "$__prompt_git"
        set git_info " ($__prompt_git)"
    end

    set -l venv_info
    if set -q __prompt_venv; and test -n "$__prompt_venv"
        set venv_info "($__prompt_venv)"
    end

    printf "%s%s%s\n\$ " $venv_info $__prompt_pwd $git_info
end

function fish_title
    # When a command is running, show the command name
    if set -q argv[1]
        echo $argv[1]
    else
        # When idle, show current directory
        prompt_pwd
    end
end
