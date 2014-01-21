# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="blinks"

# Example aliases
alias zshconfig="vim ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Comment this out to disable weekly auto-update checks
DISABLE_AUTO_UPDATE="true"

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
# COMPLETION_WAITING_DOTS="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git fasd)

eval "$(fasd --init auto)"

source $ZSH/oh-my-zsh.sh

# Customize to your needs...
export PATH=/usr/lib/lightdm/lightdm:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/home/p/depot_tools:/home/p/libav:/home/p/llvm/projects/compiler-rt/lib/asan/scripts/

###########################################
# custom
###########################################

#for iltrans
ulimit -s unlimited 

# Creates an archive from given directory
mktar() { tar cvf  "${1%%/}.tar"     "${1%%/}/"; }
mktgz() { tar cvzf "${1%%/}.tar.gz"  "${1%%/}/"; }
mktbz() { tar cvjf "${1%%/}.tar.bz2" "${1%%/}/"; }
 
#----------------------------------------
# aliases
#----------------------------------------
function ext()      # Handy Extract Program.
{
     if [ -f $1 ] ; then
         case $1 in
             *.tar.bz2)   tar xvjf $1     ;;
             *.tar.gz)    tar xvzf $1     ;;
             *.bz2)       bunzip2 $1      ;;
             *.rar)       unrar x $1      ;;
             *.gz)        gunzip $1       ;;
             *.tar)       tar xvf $1      ;;
             *.tbz2)      tar xvjf $1     ;;
             *.tgz)       tar xvzf $1     ;;
             *.zip)       unzip $1        ;;
             *.Z)         uncompress $1   ;;
             *.7z)        7z x $1         ;;
             *)           echo "'$1' cannot be extracted via >extract<" ;;
         esac
     else
         echo "'$1' is not a valid file"
     fi
}
 
nkill()
{
    pgrep $1 | xargs kill -9
}
 
alias df='df -h'
alias du='du -h -c'
alias reload='source ~/.zshrc'
 
alias ..='cd ..'
alias l='ls'
alias la='ls -la'
alias pa='ps aux'
alias sap='sudo apt-get'
alias sapi='sap install'
alias sapiy='sapi -y'
alias v='vim'
alias apts='aptitude search'

alias gits='git status'
alias gitsu='git status -uno'
alias gau='git add -u'
alias gcm='git commit -m '
alias gpom='git push origin master'
 
#Timestamps
alias stamp='date "+%Y%m%d%a%H%M"'
alias da='date "+%Y-%m-%d %A    %T %Z"'
 
#show most popular commands
alias top-commands='history | awk "{print $2}" | awk "BEGIN {FS=\"|\"} {print $1}" |sort|uniq -c | sort -rn | head -10'

alias obji='objdump -M intel '
alias pint='pin -t ~/bap-0.7/pintraces/obj-ia32/gentrace.so'

alias chelp='clang -cc1 -analyzer-checker-help'
alias anal='clang++ -cc1 -analyze -analyzer-checker=alpha.core.NegArrSize -std=c++11'
alias checks='~/llvm/tools/clang/lib/StaticAnalyzer/Checkers/'
alias scan-build='~/build/Release+Asserts/bin/scan-build'
alias scan-view='~/llvm/tools/clang/tools/scan-view/scan-view'
alias scan-build1='~/llvm/tools/clang/tools/scan-build/scan-build --use-analyzer ~/build/Release+Asserts/bin/clang++'
export PATH=/home/p/build/Release+Asserts/bin:$PATH:/home/p/bap-0.7/pin:/home/p/bap-0.7/utils:/home/p/BAP/custom_utils
export PATH=$PATH:~/.cabal/bin:~/.xmonad/bin
