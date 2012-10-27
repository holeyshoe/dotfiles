HISTFILE=~/.zsh_history
HISTSIZE=1000
SAVEHIST=1000
setopt appendhistory
bindkey -e
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/holeyshoe/.zshrc'

autoload -Uz compinit promptinit colors && colors
compinit
promptinit

PROMPT="%{$fg[white]%}[%{$fg[green]%}%n%{$reset_color%}@%{$fg[white]%}%m %{$fg[yellow]%}%1~%{$fg[white]%}]%{$fg[green]%}%#%{$reset_color%}"

# Exports
export EDITOR=vim
export BROWSER=chromium

# Keybinds
bindkey "\e[1~" beginning-of-line # Home
bindkey "\e[4~" end-of-line # End
bindkey "\e[5~" beginning-of-history # PageUp
bindkey "\e[6~" end-of-history # PageDown
bindkey "\e[2~" quoted-insert # Ins
bindkey "\e[3~" delete-char # Del
bindkey "\e[5C" forward-word
bindkey "\eOc" emacs-forward-word
bindkey "\e[5D" backward-word
bindkey "\eOd" emacs-backward-word
bindkey "\e\e[C" forward-word
bindkey "\e\e[D" backward-word
bindkey "\e[Z" reverse-menu-complete # Shift+Tab
# for rxvt
bindkey "\e[7~" beginning-of-line # Home
bindkey "\e[8~" end-of-line # End

# Aliases
alias ls='ls -h --color=auto'
alias df='df -h'
alias cls='clear'
alias steam='wine ~/.local/share/wineprefixes/steam/drive_c/Program\ Files\ \(x86\)/Steam/Steam.exe -no-dwrite >/dev/null 2>&1 &'
alias ..='cd ..'
alias pacman='pacman-color'
alias pacup='sudo pacman-color -Syyu'
alias halt='sudo halt'
alias reboot='sudo reboot'
alias connections='~/bin/connections color compact'
alias term-colors='~/bin/term-colors.sh'
alias youtube-dl='youtube-dl -t'
alias ftl='~/bin/FTL/FTL'
