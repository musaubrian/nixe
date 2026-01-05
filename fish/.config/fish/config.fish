status is-interactive; or exit

if test -f ~/.aliases
    source ~/.aliases
end

function navigate
    set -l result (bash ~/.local/bin/scripts/f.sh fish)
    if test -n "$result"; and test "$result" != "[ERROR]: No directory selected"
        cd "$result"
    end
end

function sessions
    bash ~/.local/bin/scripts/detached.sh
end

bind \ef navigate
bind \ed sessions


if test -d "$HOME/.local/bin"
    set -gx PATH "$HOME/.local/bin" $PATH
end

set -gx GOPATH "$HOME/go"
set -gx PATH $PATH /usr/local/go/bin "$GOPATH/bin"
set -gx VISUAL nvim
set -gx EDITOR "$VISUAL"

set -gx ANDROID_HOME "$HOME/Android/Sdk"
set -gx PATH $PATH "$ANDROID_HOME/emulator" "$ANDROID_HOME/platform-tools"

set -gx PATH $PATH "$HOME/.cargo/bin"

set -gx PATH $PATH "$HOME/thirdparty/zig"

set -gx NEXT_TELEMETRY_DEBUG 1

gg -lst

if test -f "$HOME/.cargo/env"
end

alias reload='source ~/.config/fish/config.fish; and clear'
