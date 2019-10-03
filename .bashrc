# ~/.bashrc: executed by bash(1) for non-login shells.

# Note: PS1 and umask are already set in /etc/profile. You should not
# need this unless you want different defaults for root.
# PS1='${debian_chroot:+($debian_chroot)}\h:\w\$ '
# umask 022
PS1="\`if [ \$? = 0 ]; then echo \[\e[33m\]0w0\[\e[0m\]; else echo \[\e[31m\]O_O\[\e[0m\]; fi\`\[\e[31m\][\[\e[m\]\[\e[34m\]\u\[\e[m\]\[\e[32m\]@\[\e[m\]\[\e[35;40m\]\h\[\e[m\]\[\e[31m\]]\[\e[m\]\[\e[31m\]―\[\e[m\]\[\e[31m\][\[\e[m\]\[\e[36m\]\w\[\e[m\]\[\e[31m\]]\[\e[m\]\[\e[33m\]☭\[\e[m\] "



# You may uncomment the following lines if you want `ls' to be colorized:
export LS_OPTIONS='--color=auto'
eval "`dircolors`"
alias ls='ls $LS_OPTIONS'
alias ll='ls $LS_OPTIONS -l'
alias l='ls $LS_OPTIONS -lA'
#
# Some more alias to avoid making mistakes:
# alias rm='rm -i'
# alias cp='cp -i'
# alias mv='mv -i'
alias myip='curl https://ipinfo.io/ip'
alias vim='nvim'
alias merg='xrdb -merge /home/adri/.Xresources'
alias pac='sudo pacman -S'
alias d='ssh dietpi@192.168.0.10'
alias i3conf='nvim /home/adri/.config/i3/config'
alias bashrc='nvim /home/adri/.bashrc'
alias nvimconf='nvim /home/adri/.config/nvim/init.vim'
alias randomvpn='sudo protonvpn-cli -r connect'
alias fastvpn='sudo protonvpn-cli -f connect'
alias fastp2pvpn='sudo protonvpn-cli -p2p connect'
alias stopvpn='sudo protonvpn-cli -d'
alias vpn ='sudo pvpn'

export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"
