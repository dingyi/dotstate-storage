# Prioritize ARM Homebrew
fish_add_path /opt/homebrew/bin
fish_add_path /opt/homebrew/sbin

starship init fish | source # https://starship.rs/
zoxide init fish | source # 'ajeetdsouza/zoxide'
fzf --fish | source

set -Ux BAT_THEME "Catppuccin Latte" # 'sharkdp/bat' cat clone
set -Ux EDITOR nvim # 'neovim/neovim' text editor
set -Ux FZF_DEFAULT_COMMAND "fd -H -E '.git'"

# NodeJS
set -gx PATH node_modules/.bin $PATH

# Go
set -g GOPATH $HOME/go
set -gx PATH $GOPATH/bin $PATH

set -Ux FZF_DEFAULT_OPTS (printf '%s ' \
    '--layout=reverse' \
    '--info=hidden' \
    '--ansi' \
    '--pointer=👉' \
    '--gutter=" "' \
    '--color=current-bg:-1' \
    '--color=current-fg:blue' \
    '--color=gutter:-1' \
    '--color=header-bg:-1' \
    '--color=header-border:cyan' \
    '--color=hl+:yellow' \
    '--color=hl:yellow' \
    '--color=input-border:yellow' \
    '--color=list-border:blue' \
    '--color=pointer:blue' \
    '--color=preview-border:cyan' | string collect)

# It is strongly recommended to store secrets in a separate, untracked file.
# For example, create a file like ~/.config/fish/conf.d/secrets.fish and add:
# set -gx ANTHROPIC_AUTH_TOKEN "YOUR_SECRET_TOKEN"
set -gx ANTHROPIC_AUTH_TOKEN "sk-..." # TODO: Replace with your actual token, preferably from a secret management solution.
set -gx ANTHROPIC_BASE_URL "https://pmpjfbhq.cn-nb1.rainapp.top"

# pnpm
set -gx PNPM_HOME "/Users/dingyi/Library/pnpm"
fish_add_path "$PNPM_HOME"
# pnpm end

# bun
set -gx BUN_INSTALL "$HOME/.bun"
fish_add_path "$BUN_INSTALL/bin"

## Settings
set -g theme_display_git_stashed_verbose yes
set -g theme_display_git_master_branch yes
set -g theme_display_git_untracked yes
set -g theme_display_git_dirty yes
set -g theme_display_nvm yes
set -g theme_display_virtualenv yes
set -g theme_display_user yes
set -g theme_display_hostname yes
set -g theme_color_scheme zenburn
set -g theme_date_format "+%Y-%m-%d %H:%M:%S"

function fish_greeting
    fastfetch
end

# File system
alias ls='eza -lh --group-directories-first --icons'
alias lsa='ls -a'
alias lt='eza --tree --level=2 --long --icons --git'
alias lta='lt -a'
alias ff="fzf --preview 'batcat --style=numbers --color=always {}'"
alias fd='fdfind'
# Prefer abbr over overriding builtin cd (interactive only)
if not abbr --query cd
    abbr --add cd z
end

# Directories
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

# Tools
alias n='nvim'
alias ss='ncspot'
alias g='git'
alias gg='gh dash'
alias d='docker'
alias bat='batcat'
alias ls='eza'
alias lzg='lazygit'
alias lzd='lazydocker'
alias zz='zellij'
alias tt='tmux a -f ~/.config/tmux/tmux.conf'
alias tls='tmux ls'
alias wsc='wt switch --create --execute=claude'
alias ddd ='npx @iannuttall/dotagents'

# Git
alias gcm='git commit -m'
alias gcam='git commit -a -m'
alias gcad='git commit -a --amend'

# codex
alias codex-yolo="codex --yolo"
alias codex-5h="codex -m gpt-5-codex -c model_reasoning_effort='high' --yolo --search"

# claude code
alias ccc='claude --dangerously-skip-permissions'
alias cc-high='claude --dangerously-skip-permissions --model opus'

# Added by LM Studio CLI (lms)
fish_add_path /Users/dingyi/.cache/lm-studio/bin

# Added by OrbStack: command-line tools and integration
# This won't be added again if you remove it.
if test -f ~/.orbstack/shell/init2.fish
    source ~/.orbstack/shell/init2.fish 2>/dev/null
end

fish_add_path /Users/dingyi/.spicetify

fish_add_path $HOME/.local/bin


# ami
set --export AMI_INSTALL "$HOME/.ami"
set --export PATH $AMI_INSTALL/bin $PATH

# try
# eval “(try init | string collect)”

# Added by git-ai installer on Wed Feb  4 21:53:12 CST 2026
fish_add_path -g "/Users/dingyi/.git-ai/bin"
