###-start-history-###
#ignoreboth = ignoredups and ignorespace
export HISTCONTROL="ignoreboth"
export HISTIGNORE="pwd*:ls*:"
export HISTFILE="~/.bash_history"
export HISTFILESIZE=1000
export HISTSIZE=1000
###-end-history-###

#####################
###-start-aliases-###
#####################
###-start-geie-aliases-###
alias sshgeietmb='ssh evaxion@217.167.188.59'
alias svnlocale='export LC_CTYPE=en_US.UTF-8'
alias cdjboss="cd ~/Dropbox/Development/geietmb/jboss-as-7.1.1.Final" #jboss 7.1 geie
###-end-geie-aliases-###
alias loginserver='/usr/X11R6/bin/X -query 192.168.7.1'
alias ll='ls -G -lisah'
alias lrt='ls -G -lrth'
alias ls='ls -G'
alias top='top -ocpu -R -F -s 2 -n30'
alias rootfinder='sudo /System/Library/CoreServices/Finder.app/Contents/MacOS/Finder'
alias screensaver='/System/Library/Frameworks/ScreenSaver.framework/Resources/ScreenSaverEngine.app/Contents/MacOS/ScreenSaverEngine -background'
alias sublimate='open -a Sublime\ Text.app'
alias idea='open -a /Applications/IntelliJ\ IDEA\ 12.app/'
alias cdext='cd /Volumes/Externe/tmp'
###-end-aliases-###

#######################
###-start-brew-cask-###
#######################
export HOMEBREW_CASK_OPTS="--appdir=/Applications"
###-end-brew-cask-###

##################
###-start-path-###
##################
#first brew
export PATH=/usr/local/sbin:/usr/local/bin:$PATH
#node
export PATH=~/npm/bin:$PATH
#java
export JAVA_HOME=$(/usr/libexec/java_home)
#Racket language for coursera Systematic Program Design
#export PATH=$PATH:"/Applications/Racket v5.3.4/bin"
#Python
#export PATH=/usr/local/share/python:$PATH
###-end-path-###

##################
###-start-ruby-###
##################
# Initialize rbenv
if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi
###-end-ruby-###

# generate .gitignore from gitignore.io
# usage : gi java,scala,osx,windows,intellij,sublimetext
#         gi list
function gi() { curl http://gitignore.io/api/$@ ;}

##################
###-Completion-###
##################

###-begin-brew-completion-###
if [ -f $(brew --prefix)/etc/bash_completion ]; then
  . $(brew --prefix)/etc/bash_completion
fi
###-end-brew-completion-###

###-begin-grunt-completion-###
eval "$(grunt --completion=bash)"
###-begin-grunt-completion-###

###-begin-git-completion-###
if [ -f `brew --prefix`/etc/bash_completion.d/git-completion.bash ]; then
    . `brew --prefix`/etc/bash_completion.d/git-completion.bash
fi
###-begin-git-completion-###

###-begin-bower-completion-###
#
# Installation: bower completion >> ~/.bashrc  (or ~/.zshrc)
# Or, maybe: bower completion > /usr/local/etc/bash_completion.d/npm
#
# Credits to npm's. Awesome completion utility.
# Bower completion script, based on npm completion script.

COMP_WORDBREAKS=${COMP_WORDBREAKS/=/}
COMP_WORDBREAKS=${COMP_WORDBREAKS/@/}
export COMP_WORDBREAKS

if type complete &>/dev/null; then
  _bower_completion () {
    local si="$IFS"
    IFS=$'\n' COMPREPLY=($(COMP_CWORD="$COMP_CWORD" \
                           COMP_LINE="$COMP_LINE" \
                           COMP_POINT="$COMP_POINT" \
                           bower completion -- "${COMP_WORDS[@]}" \
                           2>/dev/null)) || return $?
    IFS="$si"
  }
  complete -F _bower_completion bower
elif type compdef &>/dev/null; then
  _bower_completion() {
    si=$IFS
    compadd -- $(COMP_CWORD=$((CURRENT-1)) \
                 COMP_LINE=$BUFFER \
                 COMP_POINT=0 \
                 bower completion -- "${words[@]}" \
                 2>/dev/null)
    IFS=$si
  }
  compdef _bower_completion bower
elif type compctl &>/dev/null; then
  _bower_completion () {
    local cword line point words si
    read -Ac words
    read -cn cword
    let cword-=1
    read -l line
    read -ln point
    si="$IFS"
    IFS=$'\n' reply=($(COMP_CWORD="$cword" \
                       COMP_LINE="$line" \
                       COMP_POINT="$point" \
                       bower completion -- "${words[@]}" \
                       2>/dev/null)) || return $?
    IFS="$si"
  }
  compctl -K _bower_completion bower
fi
###-end-bower-completion-###

##############
###-Prompt-###
##############
###-start-git-prompt-###
source $(brew --prefix)/etc/bash_completion.d/git-prompt.sh
export GIT_PS1_SHOWCOLORHINTS=true
export GIT_PS1_SHOWDIRTYSTATE=true
export GIT_PS1_SHOWSTASHSTATE=true
export GIT_PS1_SHOWUNTRACKEDFILES=true
export GIT_PS1_SHOWUPSTREAM=true
export GIT_PS1_DESCRIBE_STYLE=branch

function configureGitPromptCommand {
  # Reset
  local Color_Off="\[\033[00m\]"       # Text Reset

  # Regular Colors
  local Black="\[\033[0;30m\]"        # Black
  local Red="\[\033[0;31m\]"          # Red
  local Green="\[\033[0;32m\]"        # Green
  local Yellow="\[\033[0;33m\]"       # Yellow
  local Blue="\[\033[0;34m\]"         # Blue
  local Purple="\[\033[0;35m\]"       # Purple
  local Cyan="\[\033[0;36m\]"         # Cyan
  local White="\[\033[0;37m\]"        # White

  # Bold
  local BBlack="\[\033[1;30m\]"       # Black
  local BRed="\[\033[1;31m\]"         # Red
  local BGreen="\[\033[1;32m\]"       # Green
  local BYellow="\[\033[1;33m\]"      # Yellow
  local BBlue="\[\033[1;34m\]"        # Blue
  local BPurple="\[\033[1;35m\]"      # Purple
  local BCyan="\[\033[1;36m\]"        # Cyan
  local BWhite="\[\033[1;37m\]"       # White

  # Underline
  local UBlack="\[\033[4;30m\]"       # Black
  local URed="\[\033[4;31m\]"         # Red
  local UGreen="\[\033[4;32m\]"       # Green
  local UYellow="\[\033[4;33m\]"      # Yellow
  local UBlue="\[\033[4;34m\]"        # Blue
  local UPurple="\[\033[4;35m\]"      # Purple
  local UCyan="\[\033[4;36m\]"        # Cyan
  local UWhite="\[\033[4;37m\]"       # White

  # Background
  local On_Black="\[\033[40m\]"       # Black
  local On_Red="\[\033[41m\]"         # Red
  local On_Green="\[\033[42m\]"       # Green
  local On_Yellow="\[\033[43m\]"      # Yellow
  local On_Blue="\[\033[44m\]"        # Blue
  local On_Purple="\[\033[45m\]"      # Purple
  local On_Cyan="\[\033[46m\]"        # Cyan
  local On_White="\[\033[47m\]"       # White

  # High Intensty
  local IBlack="\[\033[0;90m\]"       # Black
  local IRed="\[\033[0;91m\]"         # Red
  local IGreen="\[\033[0;92m\]"       # Green
  local IYellow="\[\033[0;93m\]"      # Yellow
  local IBlue="\[\033[0;94m\]"        # Blue
  local IPurple="\[\033[0;95m\]"      # Purple
  local ICyan="\[\033[0;96m\]"        # Cyan
  local IWhite="\[\033[0;97m\]"       # White

  # Bold High Intensty
  local BIBlack="\[\033[1;90m\]"      # Black
  local BIRed="\[\033[1;91m\]"        # Red
  local BIGreen="\[\033[1;92m\]"      # Green
  local BIYellow="\[\033[1;93m\]"     # Yellow
  local BIBlue="\[\033[1;94m\]"       # Blue
  local BIPurple="\[\033[1;95m\]"     # Purple
  local BICyan="\[\033[1;96m\]"       # Cyan
  local BIWhite="\[\033[1;97m\]"      # White

  # High Intensty backgrounds
  local On_IBlack="\[\033[0;100m\]"   # Black
  local On_IRed="\[\033[0;101m\]"     # Red
  local On_IGreen="\[\033[0;102m\]"   # Green
  local On_IYellow="\[\033[0;103m\]"  # Yellow
  local On_IBlue="\[\033[0;104m\]"    # Blue
  local On_IPurple="\[\033[10;95m\]"  # Purple
  local On_ICyan="\[\033[0;106m\]"    # Cyan
  local On_IWhite="\[\033[0;107m\]"   # White

  local Time12h="\T"
  local Time12a="\@"
  local PathShort="\W"
  local PathFull="\w"
  local NewLine="\n"
  local Jobs="\j"

  GIT_PROMPT_COMMAND="__git_ps1 '${Green}\u@\h:${Blue}${PathFull}${Color_Off}' '\\$ ' ' [%s]' "
}
configureGitPromptCommand
export PROMPT_COMMAND="$GIT_PROMPT_COMMAND"
###-end-git-prompt-###

###-start-change-windows-title-###
function local_dir_and_within {
  __LAST="${PWD##*/}"
  __IN="${PWD%/*}"
  __IN="${__IN/#$HOME/~}"
  TITLE_TAB="$__LAST in $__IN"
  echo -n $TITLE_TAB
}
CHANGE_WND_TITLE_PROMPT_COMMAND='echo -ne "\033]0;$(local_dir_and_within)\007"'
export PROMPT_COMMAND="$PROMPT_COMMAND;$CHANGE_WND_TITLE_PROMPT_COMMAND"
###-end-change-windows-title-###

#EOF
