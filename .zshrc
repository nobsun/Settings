unlimit

umask 022

# setting up aliases
source $HOME/.aliases

touch $HOME/.here
source $HOME/.here

# Shell functions
setenv() { typeset -x "${1}${1:+=}${(@)argv[2,$#]}" }  # csh compatibility
freload() { while (( $# )); do; unfunction $1; autoload -U $1; shift; done }

there () {
mkdir -p $1
cd $1
echo "alias $2='cd `pwd`'" >> $HOME/.here
source $HOME/.here
}

here () {
echo "alias $1='cd `pwd`'" >> $HOME/.here
source $HOME/.here
}

# work () {
# year=`date '+%Y'`
# month=`date '+%m'`
# day=`date '+%d'`
# dir=$HOME/work/$year/$month/$day
# export WORK=$dir
# mkdir -p $dir
# cd $dir
# }

# Where to look for autoloaded function definitions
fpath=($fpath ~/.zfunc)

# Autoload all shell functions from all directories in $fpath (following
# symlinks) that have the executable bit on (the executable bit is not
# necessary, but gives you an easy way to stop the autoloading of a
# particular shell function). $fpath should not be empty for this to work.
for func in $^fpath/*(N-.x:t); autoload $func

# automatically remove duplicates from these arrays
typeset -U path cdpath fpath manpath

manpath=(/usr/share/man $X11HOME/man /usr/man /usr/lang/man /usr/local/man)
export MANPATH

# Hosts to use for completion (see later zstyle)
hosts=(`hostname` ftp.math.gatech.edu prep.ai.mit.edu wuarchive.wustl.edu)

# Set prompts
#PROMPT='%Uλ .%u '    # default prompt
PROMPT='%U%m%#%u '    # default prompt
#PROMPT='%U%#%u '    # default prompt
RPROMPT=' %U%~%u'     # prompt for right side of screen
# Some environment variables
export HELPDIR=/usr/local/lib/zsh/help  # directory for run-help function to find docs

export PAGER="lv"
export USERNAME=`id -un`

HISTFILE=$HOME/.zsh-history
HISTSIZE=1000000
SAVEHIST=1000000
setopt extended_history
setopt share_history

# Set/unset  shell options
setopt   notify globdots correct pushdtohome cdablevars autolist
setopt   correctall autocd recexact longlistjobs
setopt   autoresume histignoredups pushdsilent noclobber
setopt   autopushd pushdminus extendedglob rcquotes mailwarning
unsetopt bgnice autoparamslash autoremoveslash
unsetopt correct correctall

# Autoload zsh modules when they are referenced
zmodload -a zsh/stat stat
zmodload -a zsh/zpty zpty
zmodload -a zsh/zprof zprof
zmodload -ap zsh/mapfile mapfile

bindkey -e                 # emacs key bindings
bindkey ' ' magic-space    # also do history expansion on space
bindkey '^I' complete-word # complete on tab, leave expansion to _expand

# Setup new style completion system. To see examples of the old style (compctl
# based) programmable completion, check Misc/compctl-examples in the zsh
# distribution.
autoload -U compinit
compinit

# Completion Styles

# list of completers to use
zstyle ':completion:*::::' completer _expand _complete _ignored _approximate

# allow one error for every three characters typed in approximate completer
zstyle -e ':completion:*:approximate:*' max-errors \
    'reply=( $(( ($#PREFIX+$#SUFFIX)/3 )) numeric )'
    
# insert all expansions for expand completer
zstyle ':completion:*:expand:*' tag-order all-expansions

# formatting and messages
zstyle ':completion:*' verbose yes
zstyle ':completion:*:descriptions' format '%B%d%b'
zstyle ':completion:*:messages' format '%d'
zstyle ':completion:*:warnings' format 'No matches for: %d'
zstyle ':completion:*:corrections' format '%B%d (errors: %e)%b'
zstyle ':completion:*' group-name ''

# match uppercase from lowercase
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# offer indexes before parameters in subscripts
zstyle ':completion:*:*:-subscript-:*' tag-order indexes parameters

# command for process lists, the local web server details and host completion
zstyle '*' hosts $hosts

# Filename suffixes to ignore during completion (except after rm command)
zstyle ':completion:*:*:(^rm):*:*files' ignored-patterns '*?.o' '*?.c~' \
    '*?.old' '*?.pro'

# ignore completion functions (until the _ignored completer)
zstyle ':completion:*:functions' ignored-patterns '_*'

# title bar
if [ "$TERM" = "xterm" -o "$TERM" = "kterm" ]
then
  function _setcaption() { echo -ne  "\e]1;\a\e]0;$1\a" > /dev/tty }
  function chpwd() {  print -Pn "\e]0; %~\a" }
  chpwd
  function _cmdcaption() { _setcaption " ($1)"; "$@"; chpwd }
  for cmd in telnet slogin ssh rlogin rsh su sudo
  do
    alias $cmd="_cmdcaption $cmd"
  done
fi

running_process () {
	reply=(` ps ax| awk '{print $NF}'`)
	}
compctl -K running_process + -caF ikill pid

export DARCS_DONT_ESCAPE_ANYTHING=1
export PATH=./.cabal-sandbox/bin:$HOME/.cabal/bin:$HOME/bin:$PATH
