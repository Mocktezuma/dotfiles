# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=6000
SAVEHIST=3000
setopt extendedglob notify
bindkey -v
bindkey '^R' history-incremental-search-backward
# End of lines configured by zsh-newuser-install
PF_INFO="ascii title os wm editor host hostname kernel uptime pkgs memory palette"

export ZSH=$HOME/.oh-my-zsh
export TERM="st-256color"


#fff config
f() {
    fff "$@"
    cd "$(cat "${XDG_CACHE_HOME:=${HOME}/.cache}/fff/.fff_d")"
}

export FFF_FAV1=~/Pictures/wallpapers
export FFF_FAV2=~/Videos
export FFF_FAV3=~/Src
export FFF_FAV4=~/Projects

export FFF_OPENER="xdg-open"

# streaming

streaming() {
     INRES="1920x1080" # input resolution
     OUTRES="1920x1080" # output resolution
     FPS="60" # target FPS
     GOP="120" # i-frame interval, should be double of FPS, 
     GOPMIN="60" # min i-frame interval, should be equal to fps, 
     THREADS="0" # max 6
     CBR="2500k" # constant bitrate (should be between 1000k - 3000k)
     QUALITY="medium"  # one of the many FFMPEG preset
     AUDIO_RATE="44100"
     STREAM_KEY="$1" # use the terminal command Streaming streamkeyhere to stream your video to twitch or justin
     SERVER="live-cdg" # twitch server in California, see https://bashtech.net/twitch/ingest.php to change 
     
     sudo ffmpeg -f x11grab -s "$INRES" -r "$FPS" -i :0.0 -f alsa -i pulse -f flv -ac 2 -ar $AUDIO_RATE \
       -vcodec libx264 -g $GOP -keyint_min $GOPMIN -b:v $CBR -minrate $CBR -maxrate $CBR -pix_fmt yuv420p\
       -s $OUTRES -preset $QUALITY -tune film -acodec libmp3lame -threads $THREADS -strict normal \
       -bufsize $CBR "rtmp://$SERVER.twitch.tv/app/$STREAM_KEY"      
 }


# The following lines were added by compinstall
zstyle :compinstall filename '/home/adri/.zshrc'

source /usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme

autoload -Uz compinit
compinit


# End of lines added by compinstall

# ZSH config
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=1,bg=8,bold,underline"
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern cursor)
# typeset -A ZSH_HIGHLIGHT_STYLES
# ZSH_HIGHLIGHT_STYLES[path]='fg=cyan'
# ZSH_HIGHLIGHT_STYLES[alias]='fg=magenta,bold'
# ZSH_HIGHLIGHT_STYLES[command]='fg=4,bold'
# ZSH_HIGHLIGHT_STYLES[precommand]='fg=5,italic'


# oh my zsh plugins
plugins=(pipenv npx npm pass gatsby tmux docker-compose docker-machine docker nmap systemd git git-flow archlinux colorize django vi-mode vscode taskwarrior history-substring-search)


source $ZSH/oh-my-zsh.sh


# aliases 
alias config='/usr/bin/git --git-dir=$HOME/dotfiles/ --work-tree=$HOME'

alias update='sudo pacman -Syu'
alias install='sudo pacman -S'
alias search='sudo pacman -Ss'

alias moon='curl wttr.in/Moon'
alias lausanne='curl wttr.in/Lausanne'
alias morges='curl wttr.in/Morges'

alias fSetup='export FREESURFER_HOME=$HOME/freesurfer && export SUBJECTS_DIR=$FREESURFER_HOME/subjects && source $FREESURFER_HOME/SetUpFreeSurfer.sh'
alias ytmp3='youtube-dl --add-metadata -x --audio-format best -o "~/Music/%(artist)s/%(album)s/%(title)s.%(ext)s" --audio-quality 0 --add-metadata $(xclip -o) && notify-send "youtube-dl" "download complete !" && exit'
alias update-grub='sudo grub-mkconfig -o /boot/grub/grub.cfg'
alias ls='lsd'
alias l='ls -l'
alias la='ls -a'
alias lla='ls -la'
alias lt='ls --tree'
alias vim='nvim'
alias cat='bat'

# functions
extract () {
   if [ -f $1 ] ; then
       case $1 in
           *.tar.bz2)   tar xvjf $1    ;;
           *.tar.gz)    tar xvzf $1    ;;
           *.bz2)       bunzip2 $1     ;;
           *.rar)       unrar x $1       ;;
           *.gz)        gunzip $1      ;;
           *.tar)       tar xvf $1     ;;
           *.tbz2)      tar xvjf $1    ;;
           *.tgz)       tar xvzf $1    ;;
           *.zip)       unzip $1       ;;
           *.Z)         uncompress $1  ;;
           *.7z)        7z x $1        ;;
           *)           echo "don't know how to extract '$1'..." ;;
       esac
   else
       echo "'$1' is not a valid file!"
   fi
 }

editZsh() {
    nvim $HOME/.zshrc
    source $HOME/.zshrc
    config add $HOME/.zshrc
    config commit -m "updated zshrc"
}
clonerepo() {
    cd ~/Src
    git clone $(xclip -o)
}

# exports
export PATH=$PATH:~/Android/Sdk/tools:~/Android/Sdk/platform-tools:~/Devel/flutter/bin:~/bin:~/.local/bin:/opt/wine-osu/bin
export VISUAL=/usr/bin/nvim
export EDITOR=/usr/bin/nvim



source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
