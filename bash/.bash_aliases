#!/bin/bash
# .bash_aliases

if [[ $- != *i* ]];then return; fi

#Usage :pathappend <P1> <P2> <P3> # it checks the indivisual string
pathappend() {
  for ARG in "$@"
  do
    if [ -d "$ARG" ] && [[ ":$PATH:" != *":$ARG:"* ]]; then
        PATH="${PATH:+"$PATH:"}$ARG"
    fi
  done
}

#Usage :pathprepend <P1> <P2> <P3> # it checks the indivisual string
pathprepend() {
  for ((i=$#; i>0; i--)); 
  do
    ARG=${!i}
    if [ -d "$ARG" ] && [[ ":$PATH:" != *":$ARG:"* ]]; then
        PATH="$ARG${PATH:+":$PATH"}"
    fi
  done
}

# bash does cache the full path to a command
# To clear the entire cache: $hash -r  # Or just one entry: $ hash -d <>
# https://unix.stackexchange.com/questions/5609/how-do-i-clear-bashs-cache-of-paths-to-executables
#Usage :pathadd <P1:P2:P3> # it checks the whole string
pathadd() {
    if [ -d "$1" ] && [[ ":$PATH:" != *":$1:"* ]]; then
        PATH="${PATH:+"$PATH:"}$1"
    fi
}


if [ "$BASH_TMUXALIAS_SETTINGS" == "yes" ];then
if [ "$BASH_DEBUG_SETTINGS" == "yes" ];then echo "Setting TMUXALIAS_SETTINGS=$BASH_TMUXALIAS_SETTINGS ........"; fi
# Tmux Aliases.....
alias tmux="tmux -2"
alias ts="tmux new -s"
alias ta="tmux a -t"
alias t-ls="tmux ls"
alias th="h_tmux"

alias t2s="tumx new -s"
fi

if [ "$BASH_USERALIAS_SETTINGS" == "yes" ];then
if [ "$BASH_DEBUG_SETTINGS" == "yes" ];then echo "Setting USERALIAS_SETTINGS=$BASH_USERALIAS_SETTINGS ........"; fi
# Vim Aliases
alias v='vim'
alias vi='vim'
# Vim Settings
alias v="vim"
alias vi="vim"
alias vd="vimdiff"

# grep settings
alias grep='grep -sE --color=auto'
alias grepc='grep -sE --color=always '
#alias xgrep='parallel -j4 grep -sE --color=always '
alias xgrep='xargs grep -sE '
alias xgrepc='xargs grep -sE --color=always '

alias h=history

# rm to ask conformation
alias rm='rm -i'

# ls settings
alias ls="ls --color=auto -p"
alias ll="ls -l"
alias la="ls -al"
alias ltr="ls -ltr"
alias l="ls --color=auto --format=horizontal -XF "


ucd(){
    dir=$1;
    to_dir="${!dir}"
    vob_dir="${PWD%/mucho*}/${!dir}"
    #echo "${to_dir}, ${vob_dir},  ${dir}, ${!dir}"

    if [[ $# -eq 0 ]]; then
        builtin cd $HOME;
    elif [[ "$dir" == "-" ]]; then
        builtin cd -
    elif [[ -d ${dir} ]]; then
        builtin cd $dir;
    elif [[ -d ${vob_dir} && -d ${to_dir} ]]; then
        builtin cd $vob_dir
    elif [[ -d ${to_dir} ]]; then
        builtin cd $to_dir;
    elif [[ "${dir}" = "base" ]]; then
        builtin cd  "${!dir}" ;
    else
        builtin cd  "${dir}" ;
    fi ;
    echo -e "[${PWD}]";
    echo -ne "\033]0;${HOST}: ${PWD}\007";
    echo "${PWD}" > ${HOME}/.screen_pwd_${STY#*.}
}

# display numbers in a human readable format
alias df='df -h'
alias du='du -h'
alias free='free -h'


fi

if [ "$BASH_LOCALUSERPATH_SETTINGS" == "yes" ];then
if [ "$BASH_DEBUG_SETTINGS" == "yes" ];then echo "Setting LOCALUSERPATH_SETTINGS=$BASH_LOCALUSERPATH_SETTINGS ........"; fi
# Add local tools to main path
#export PATH="$PATH:~/utils/bin:~/utils/tools"
pathappend ${HOME}/.local/bin
#export MANPATH=${MANPATH}:/usr/local/man
#export LD_LIBRARY_PATH=/usr/lib:/usr/local/lib:${HOME}/utils/lib
fi


if [ "$BASH_REDITOR_USER_BIN_PATH_SETTINGS" == "yes" ];then
if [ "$BASH_DEBUG_SETTINGS" == "yes" ];then echo "Setting REDITOR_USERPATH_SETTINGS=$BASH_REDITOR_USE_BIN_RPATH_SETTINGS ........"; fi
# Add reditor tools to main path
pathappend ${HOME}/reditor/utils/bin
pathappend ${HOME}/reditor/utils/tools
#export MANPATH=${MANPATH}:/usr/local/man
#export LD_LIBRARY_PATH=/usr/lib:/usr/local/lib:${HOME}/utils/lib
fi

if [ "$BASH_REDITOR_USER_MAN_PATH_SETTINGS" == "yes" ];then
if [ "$BASH_DEBUG_SETTINGS" == "yes" ];then echo "Setting REDITOR_MAN_PATH_SETTINGS=$BASH_REDITOR_USER_MAN_PATH_SETTINGS ........"; fi
# Add reditor Manual  to main Mamual path
#export MANPATH=${MANPATH}:/usr/local/man
export MANPATH=${MANPATH}:${HOME}/reditor/utils/man
fi

if [ "$BASH_REDITOR_USER_LD_LIB_PATH_SETTINGS" == "yes" ];then
if [ "$BASH_DEBUG_SETTINGS" == "yes" ];then echo "Setting REDITOR_LD_LIB_PATH_SETTINGS=$BASH_REDITOR_USER_LD_LIB_PATH_SETTINGS ........"; fi
# Add reditor LD_LIB to main LD_LIB path
#export LD_LIBRARY_PATH=/usr/lib:/usr/local/lib:${HOME}/utils/lib
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:${HOME}/reditor/utils/lib
fi

if [ "$BASH_HISTORY_SETTINGS" == "yes" ];then
if [ "$BASH_DEBUG_SETTINGS" == "yes" ];then echo "Setting HISTORY_SETTINGS=$BASH_HISTORY_SETTINGS ........"; fi
# History search :use "bind -p to display all settings
bind '"\e[A":history-search-backward'
bind '"\e[B":history-search-forward'
bind '"\e[1~": beginning-of-line'     # Home key
bind '"\e[4~": end-of-line'           # End key
# History search for bash shell
# The following line ensures that history logs screen commands as well
shopt -s histappend
# This line makes the history file to be rewritten and reread at each bash prompt
#PROMPT_COMMAND="$PROMPT_COMMAND history -a; history -c; history -r"
#PROMPT_COMMAND="$PROMPT_COMMAND history -a"
#export PROMPT_COMMAND='history -a; history -r'
#PROMPT_COMMAND='history -a'
PROMPT_COMMAND='echo -ne "\033]12;green\007"; history -a'
# Have lots of history
HISTSIZE=100000         # remember the last 100000 commands
HISTFILESIZE=100000     # start truncating commands after 100000 lines
HISTCONTROL=ignoreboth  # ignoreboth is shorthand for ignorespace and     ignoredups
#if [[ $- == *i* ]]
#then
    #bind '"\e[A": history-search-backward'
    #bind '"\e[B": history-search-forward'
#fi
fi

if [ "$BASH_KG_SETTINGS" == "yes" ];then
if [ "$BASH_DEBUG_SETTINGS" == "yes" ];then echo "Setting KG_SETTINGS=$BASH_KG_SETTINGS ........"; fi
alias kgn="kg --nocache " 
fi

if [ "$BASH_USERBASH_SETTINGS" == "yes" ];then
if [ "$BASH_DEBUG_SETTINGS" == "yes" ];then echo "Setting USERBASH_SETTINGS=$BASH_USERBASH_SETTINGS ........"; fi
if [ ! -f "/bin/bash" ]; then
    export SHELL=~/reditor/utils/bin/bash
fi
fi

if [ "$BASH_SPACE_SETTINGS" == "yes" ];then
if [ "$BASH_DEBUG_SETTINGS" == "yes" ];then echo "Setting SPACE_SETTINGS=$BASH_SPACE_SETTINGS ........"; fi
#bind Space:magic-space
#bind '"\e0"':"\"\!:0 \""
#bind '"\e1"':"\"\!:1 \""
#bind '"\e2"':"\"\!:2 \""
#bind '"\e3"':"\"\!:3 \""
#bind '"\e4"':"\"\!:4 \""
#bind '"\e5"':"\"\!:5 \""
#bind '"\e6"':"\"\!:6 \""
##bind '"\e7"':"\"\!:7 \""
##bind '"\e8"':"\"\!:8 \""
#bind '"\e9"':"\"\!:9 \""

bind Space:magic-space
bind '"^[[11~"':"\"\!:0 \""
bind '"^[[12~"':"\"\!:1 \""
bind '"^[[13~"':"\"\!:2 \""
bind '"^[[14~"':"\"\!:3 \""
bind '"^[[15~"':"\"\!:4 \""
bind '"^[[17~"':"\"\!:5 \""
bind '"^[[18~"':"\"\!:6 \""
bind '"^[[19~"':"\"\!:7 \""
bind '"^[[20~"':"\"\!:8 \""
bind '"^[[21~"':"\"\!:9 \""

fi

if [ "$BASH_EDITOR_SETTINGS" == "vi" ];then
if [ "$BASH_DEBUG_SETTINGS" == "yes" ];then echo "Setting EDITOR_SETTINGS=$BASH_EDITOR_SETTINGS ........"; fi

#export PS1="# "

#set bell-style nd '"\t":menu-complete'
bind -m vi-insert "\C-p":dynamic-complete-history
bind -m vi-insert "\C-n":menu-complete
bind -m vi-insert "\C-l":clear-screen
#bind -m vi-insert '" "':menu-completenone

bind '"\en"':"\"^N\""
bind '"\ef"':"\"find  \ei\""
bind '"\em"':"\" -name \"*.[csh]\"\ei\""
bind '"\e\\"':"\"\eA| \ei\""
bind '"\es"':"\"\eA  xgrep  \"\"\ei\""
bind '"\eg"':"\"\eA  grep \"\"\ei \""

#ALT +X xgrep
bind -m vi-command '"\ex"':"\"\eA xgrep  \"\"\ei\""
bind -m vi-insert  '"\ex"':"\"\eA xgrep  \"\"\ei\""

bind  -m vi-command '"^[[4~"':vi-append-eol # END KEY
bind  -m vi-command '"^[[1~"':vi-insert-beg # HOME KEY
bind  -m vi-command '"^[[3~"':vi-delete # DELETE
bind  -m vi-command '"^[[2~"':vi-insertion-mode # INSERT KEY
bind  -m vi-command '"^?"':backward-delete-char
bind  -m vi-command '"^H"':backward-delete-char

bind  -m vi-insert '"^[[4~"':vi-append-eol
bind  -m vi-insert '"^[[1~"':vi-insert-beg
bind  -m vi-insert '"^[[3~"':vi-delete
bind  -m vi-insert '"^[[2~"':vi-insertion-mode
bind  -m vi-insert '"^H"':backward-delete-char

bind -m vi-command '"\ek"':"\"kA\""
bind -m vi-insert  '"\ek"':"\"\ekA\""
bind -m vi-command '"\ej"':"\"jA\""
bind -m vi-insert  '"\ej"':"\"\ejA\""

#ALT + BACKSPACE
bind -m vi-command '"\e^?"':backward-kill-word
bind -m vi-insert  '"\e^?"':backward-kill-word
bind -m vi-command '"\e^H"':backward-kill-word
bind -m vi-insert  '"\e^H"':backward-kill-word

# ALT + DELELTE
bind -m vi-command '"\e^[[3~"':kill-word
bind -m vi-insert  '"\e^[[3~"':kill-word

# ALT + DELELTE
bind -m vi-command '"\e^[[3~"':kill-word
bind -m vi-insert  '"\e^[[3~"':kill-word

# ALT + SEARCH(. and ,)
bind -m vi-command '"\e."':forward-word
bind -m vi-insert  '"\e."':forward-word
bind -m vi-command '"\e,"':backward-word
bind -m vi-insert  '"\e,"':backward-word

# ALT + MOVE cursor (h,l)
bind -m vi-command '"\eh"':"\"h\""
bind -m vi-insert  '"\eh"':"\"\ei\""
bind -m vi-command '"\el"':"\"l\""
bind -m vi-insert  '"\el"':"\"\eli\""

# ALT + MOVE word (r,f)
bind -m vi-command '"\er"':backward-word
bind -m vi-insert  '"\er"':backward-word
bind -m vi-command '"\et"':forward-word
bind -m vi-insert  '"\et"':forward-word

# ALT + MOVE cursor(end,beg)
bind -m vi-command '"\ee"':vi-append-eol
bind -m vi-insert  '"\ee"':vi-append-eol
bind -m vi-command '"\eb"':vi-insert-beg
bind -m vi-insert  '"\eb"':vi-insert-beg

#Alt + arrow
bind -m vi-insert   '"\e\e[C"':forward-word
bind -m vi-command  '"\e\e[C"':forward-word
bind -m vi-insert   '"\e\e[D"':backward-word
bind -m vi-command  '"\e\e[D"':backward-word

# Alt + D - delete a word
bind -m vi-command '"\ed"':"\"dwi\""
bind -m vi-insert  '"\ed"':"\"\eldwi\""

# Alt + X - delete a char
#bind -m vi-command '"\ex"':"\"\exi\""
#bind -m vi-insert  '"\ex"':"\"\exi\""

# Alt + / -  search
bind -m vi-command '"\e/"':"\"\e/\""
bind -m vi-insert  '"\e/"':"\"\e/\""


# Alt + / -  ../
bind -m vi-command '"\e;"':"\"../\""
bind -m vi-insert  '"\e;"':"\"../\""

# Alt + T - telnet
#bind -m vi-command '"\et"':"\"itelnet \""
#bind -m vi-insert  '"\et"':"\"telnet \""

# Alt + I - IP
#bind -m vi-command '"\eo"':"\"i10.37.73.1\""
#bind -m vi-insert  '"\eo"':"\"10.37.73.1\""


#ALT + *
bind '"\e7"':"\"\&\""
bind '"\e8"':"\"\*\""

#ALT + k
bind -m vi-command '"\ek"':history-search-backward
bind -m vi-insert  '"\ek"':history-search-backward

#ALT + j
bind -m vi-command '"\ej"':history-search-forward
bind -m vi-insert  '"\ej"':history-search-forward


#ALT + p
bind -m vi-command '"\ei"':paste-from-clpboard
bind -m vi-insert  '"\ei"':paste-from-clpboard

fi

if [ "$BASH_AUTO_SETTINGS" == "yes" ];then
if [ "$BASH_DEBUG_SETTINGS" == "yes" ];then echo "Setting AUTO_SETTINGS=$BASH_AUTO_SETTINGS ........"; fi
set -o vi
set editing-mode vi
set keymap vi
set convert-meta on
set bell-style none
set echo-control-characters off
set show-all-if-ambiguous on
#single tab completion
set completion-query-items 3500
set completion-ignore-case on
fi

if [ "$BASH_PERMISSION_SETTINGS" == "yes" ];then
if [ "$BASH_DEBUG_SETTINGS" == "yes" ];then echo "Setting PERMISSION_SETTINGS=$BASH_PERMISSION_SETTINGS ........"; fi
#default permision
#umask 0000
umask 0022
fi


if [ "$BASH_LINEWRAP_SETTINGS" == "yes" ];then
if [ "$BASH_DEBUG_SETTINGS" == "yes" ];then echo "Setting LINEWRAP_SETTINGS=$BASH_LINEWRAP_SETTINGS ........"; fi
## turn off linewrap
#printf %b '\033[?7l'

## turn on linewrap
 #printf %b '\033[?7h'

#or using tput:

## turn off linewrap
#tput smam

## turn on linewrap
#tput rmam

#show rows and columns
    #tput cols
    #tput lines

fi

if [ "$BASH_STTY_SETTINGS" == "yes" ];then
if [ "$BASH_DEBUG_SETTINGS" == "yes" ];then echo "Setting STTY_SETTINGS=$BASH_STTY_SETTINGS ........"; fi
stty -ixon
#change
    #stty rows 44
    #stty cols 200
fi

if [ "$BASH_HIST_SETTINGS" == "yes" ];then
if [ "$BASH_DEBUG_SETTINGS" == "yes" ];then echo "Setting HIST_SETTINGS=$BASH_HIST_SETTINGS ........"; fi
export EDITOR=vim
export PROMPT_COMMAND=""
export PROMPT_COMMAND="$PROMPT_COMMAND history -a "
export HISTFILESIZE=9999999999 # the bash history should save 3000 commands
export HISTSIZE=99999999999

export HISTIGNORE="pwd:ls:dir"
#export HISTCONTROL=ignorespace:erasedups
export HISTCONTROL=erasedups
export HISTFILE=~/.bash_history
#export HISTTIMEFORMAT='%F %T '
export HISTTIMEFORMAT=' '
shopt -s histappend
shopt -s cmdhist
shopt -s expand_aliases

#Set up history size unlimited
#unset HISTSIZE
#unset HISTFILESIZE
shopt -s histappend

#shopt -s failglob
#shopt -s nullglob
#shopt -s direxpand
#
## Expand aliases defined in the shell ~/.bashrc
#shopt -s expand_aliases
fi

if [ "$BASH_COLOR_SETTINGS" == "yes" ];then
if [ "$BASH_DEBUG_SETTINGS" == "yes" ];then echo "Setting COLOR_SETTINGS=$BASH_COLOR_SETTINGS ........"; fi
# Define a few Color's
BLACK='\e[0;30m'
BLUE='\e[0;34m'
GREEN='\e[0;32m'
CYAN='\e[0;36m'
RED='\e[0;31m'
PURPLE='\e[0;35m'
BROWN='\e[0;33m'
LIGHTGRAY='\e[0;37m'
DARKGRAY='\e[1;30m'
LIGHTBLUE='\e[1;34m'
LIGHTGREEN='\e[1;32m'
LIGHTCYAN='\e[1;36m'
LIGHTRED='\e[1;31m'
LIGHTPURPLE='\e[1;35m'
YELLOW='\e[1;33m'
WHITE='\e[1;37m'
NC='\e[0m'              # No Color
source ${HOME}/reditor/bash/.bashrc_color_module
fi

if [ "$BASH_LSCOLOR_SETTINGS" == "yes" ];then
if [ "$BASH_DEBUG_SETTINGS" == "yes" ];then echo "Setting LSCOLOR_SETTINGS=$BASH_LSCOLOR_SETTINGS ........"; fi
#echo -ne "\033[30;47m\033[2J\033[1;1H";
#alias ls='ls --color'
#LS_COLORS='di=38;5;33:fi=38;5;124:ln=38;5;127:pi=33:so=35:bd=36:cd=37:or=37:mi=30:ex=32:*.rpm=90'
#export LS_COLORS
#Rashmi LA_COLOR 4
#LS_COLORS='rs=0:di=01;34:ln=01;36:mh=00:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:mi=01;05;37;41:su=37;41:sg=30;43:ca=30;41:tw=30;42:ow=34;42:
#The first line makes ls use the --color parameter by default, which tells ls to display files in different colours based on the setting of the LS_COLORS variable.

#The second line is the tricky one, and what I have worked out so far has been by trial and error.  The parameters (di, fi, etc.) refer to different Linux file type

#di = directory
#fi = file
#ln = symbolic link
#pi = fifo file
#so = socket file
#bd = block (buffered) special file
#cd = character (unbuffered) special file
#or = symbolic link pointing to a non-existent file (orphan)
#mi = non-existent file pointed to by a symbolic link (visible when you type ls -l)
#ex = file which is executable (ie. has 'x' set in permissions). ex = file which is executable (ie. has 'x' set in permissions).

source ${HOME}/reditor/bash/.bashrc_ls_color
fi

if [ "$BASH_COMPLETION_SETTINGS" == "yes" ];then
if [ "$BASH_DEBUG_SETTINGS" == "yes" ];then echo "Setting COMPLETION_SETTINGS=$BASH_COMPLETION_SETTINGS ........"; fi
# Alter the following to reflect the location of this file.
#if [[ ! -f /etc/bash_completion ]]; then
    #export BASH_COMPLETION=~/.bash_completion
    #export BASH_COMPLETION_DIR=~/.bash_completion.d
    #export BASH_COMPLETION_COMPAT_DIR=~/.bash_completion.d
    #. ~/.bash_completion
#fi
fi

if [ "$BASH_PYTHONPATH_SETTINGS" == "yes" ];then
if [ "$BASH_DEBUG_SETTINGS" == "yes" ];then echo "Setting PYTHONPATH_SETTINGS=$BASH_PYTHONPATH_SETTINGS ........"; fi
export PYTHONPATH=${HOME}/utils/lib/python2.7/site-packages
fi

if [ "$BASH_TOUCHFILE_SETTINGS" == "yes" ];then
if [ "$BASH_DEBUG_SETTINGS" == "yes" ];then echo "Setting TOUCHFILE_SETTINGS=$BASH_TOUCHFILE_SETTINGS ........"; fi
#touch ~/.bashrc_custom_profile_user
#touch ~/.custom_vimrc
#. ~/.bashrc_custom_profile_user_pn
fi

if [ "$BASH_GTAGS_SETTINGS" == "yes" ];then
if [ "$BASH_DEBUG_SETTINGS" == "yes" ];then echo "Setting GTAGS_SETTINGS=$BASH_GTAGS_SETTINGS ........"; fi
alias p="VGtags p"
alias x="VGtags x"
alias cx="VGtags cx"
alias d="VGtags dx"
alias c="VGtags c"
alias r="VGtags r"
alias s="VGtags s"
alias g="VGtags g"
alias DIFF="DiffFiles "

alias getp="global -P "
alias getx="global -x "
alias getc="global -c "
alias getr="global -rx "
alias gets="global -s "
alias getg="global -gx "

#Gtags treats .h file as C and .hh/.hpp for C++, so do not refer classes in .h file
export GTAGSFORCECPP=   #This makes Gtags treat .h file as C++
#Gtags support C,CPP, to support Python and all install "pygments" and enable below 2 lines
#export GTAGSCONF=/usr/local/share/gtags/gtags.conf
#export GTAGSLABEL=pygments

fi

if [ "$BASH_CTAGS_SETTINGS" == "yes" ];then
if [ "$BASH_DEBUG_SETTINGS" == "yes" ];then echo "Setting CTAGS_SETTINGS=$BASH_CTAGS_SETTINGS ........"; fi
alias tags='ctags -R -f tags '
alias atags='ctags -R --c++-kinds=+p --fields=+iaS --extra=+q -f atags '

#Cscope
#Enable velow for cscope open VIM (by default cscope uses VI not VIM)
export CSCOPE_EDITOR=`which vim`

alias csp="VCs f"
alias csx="VCs g"
alias csr="VCs s"
alias csc="VCs c"
alias cse="VCs e"

function utags(){
    if  [[ -n $1  ]] ; then (cd $1; ctags -R --c++-kinds=+p --fields=+iaS --extra=+q -f atags;);  return ; fi
}
fi

# Control for the working CVS
if [ "$BASH_DEBUG_SETTINGS" == "yes" ];then echo "Setting CVS_SETTINGS=$BASH_CVS_SETTINGS ........"; fi
if [ "$BASH_CVS_SETTINGS" == "git" ];then
    unset SSH_ASKPASS # https://stackoverflow.com/questions/16077971/git-produces-gtk-warning-cannot-open-display
                    # Solution to : (gnome-ssh-askpass:29241): Gtk-WARNING **: cannot open display
    alias lsco-a='git status -s --untracked-files=no'
    alias lsco-al="git status -s --untracked-files=all"
    alias vdiff='git difftool --tool=vimdiff --no-prompt'
    alias cdiff='git diff'
    alias gdlist='git diff --name-status' #'git diff --name-only'
    alias cpatch='git apply -v'
elif [ "$BASH_CVS_SETTINGS" == "mercurial" ];then
    alias lsco-a='hg status -m'
    alias lsco-al="hg status"
    alias vdiff='hg vimdiff'
    alias cdiff='hg diff'
    alias cpatch='hg import --no-commit'
    alias review-gen='hg webrev'
    alias update_view='hg pull -u'
    alias uco='hg revert'
    alias revert='revert_all_and_backup'
    alias ucout="uncheckout"

# Org Specific
    alias bld="gmake OPTIMIZER=-g"
    alias rd="cd /build/rrout"
    alias wd="cd /build/webrev/rrout"

    alias insw='bash /build/rrout/dbg/switchinstall.sh'
    alias cpsw='bash /build/rrout/dbg/switchinstallnvOSBin.sh'
    #PATH="$PATH:/opt/onbld/bin"
    pathappend /opt/onbld/bin

# End Org Specific

    uncheckout() {
        if [ $# != 1 ]; then
            echo "Usage: uncheckout <name>"
        else
            read -r -p "Keep backup? [y/n] " response
            case "$response" in
                [yY][eE][sS]|[yY])
                hg diff $1 > $1.patch.$(date +%Y-%m-%d:%H:%M);
                cp $1 $1.keep.$(date +%Y-%m-%d:%H:%M);
                hg revert $1
                echo -e "Saved : $1.patch.$(date +%Y-%m-%d:%H:%M)"
                echo -e "Saved : $1.keep.$(date +%Y-%m-%d:%H:%M)"
                ;;
            *)
                hg revert $1
                ;;
            esac
            #mkdir -p $1 && cd $1
        fi
    }

    uncheckout() {
        if [ $# != 1 ]; then
            echo "Usage: uncheckout <name>"
        else
            read -r -p "Keep backup? [y/n] " response
            case "$response" in
                [yY][eE][sS]|[yY])
                hg diff $1 > $1.patch.$(date +%Y-%m-%d:%H:%M);
                cp $1 $1.keep.$(date +%Y-%m-%d:%H:%M);
                hg revert $1
                echo -e "Saved : $1.patch.$(date +%Y-%m-%d:%H:%M)"
                echo -e "Saved : $1.keep.$(date +%Y-%m-%d:%H:%M)"
                ;;
            *)
                hg revert $1
                ;;
            esac
            #mkdir -p $1 && cd $1
        fi
    }

    revert_all_and_backup() {
        #echo -e "$#";echo -e "$1";echo -e "$?"
        if [ $# != 0  ]; then
            echo -e "Error : Shouldn't specify argument"
            return
        fi
        read -r -p "It will save diff in current directory and revert all? [y/n] " response
        case "$response" in
            [yY][eE][sS]|[yY])
            #hg diff > AUTO_BKP_$(date +%F+%T).diff; hg revert --all
            hg diff > AUTO_BKP_$(date +%Y-%m-%d:%H:%M).diff;
            hg status -n -m > AUTO_BKP_FILES_$(date +%Y-%m-%d:%H:%M).diff
            #hg revert $1 --all
            hg revert --all
            echo -e "Saved : AUTO_BKP_$(date +%Y-%m-%d:%H:%M).diff"
            echo -e "Saved : AUTO_BKP_FILES_$(date +%Y-%m-%d:%H:%M).diff"
            ;;
            *)
            echo -e "Thanks!!!!!"
        esac
    }
elif [ "$BASH_CVS_SETTINGS" == "clearcase" ];then
    alias ct="cleartool"
    alias cd="ucd"
    alias lsco-a='hg status -m'
    alias lsco-al="hg status"
    alias vdiff='hg vimdiff'
    alias cdiff='hg diff'
    alias cpatch='hg import --no-commit'
    alias review-gen='hg webrev'
    alias update_view='hg pull -u'
    alias uco='hg revert'
    alias revert='revert_all_and_backup'
    alias ucout="uncheckout"
    function cvdiff()
    {
        #sh -c "$(cleartool ls $1 | sed  -e '/CHECKEDOUT/{s/\(.*\)@@\(.*CHECKEDOUT\).from.\(.*\) *Rule:.*/echo vimdiff \1 \1@@\3/g;;n;}' -e 's/\(.*\)\/\([0-9]\+\)[ \t]*.*/echo vimdiff \1\/\2 \1\/$( echo \2-1|bc) /g'|sh)"
        sh -c "$(cleartool ls -short $1 | sed  -e '/CHECKEDOUT/{s/\(.*\)@@\(.*\)CHECKEDOUT/echo vimdiff \1 \1@@\2LATEST/g;;n;}' -e 's/\(.*\)\/\([0-9]\+\)[ \t]*.*/echo vimdiff \1\/\2 \1\/$( echo \2-1|bc) /g'|sh)"
    }
    function cvdiffl()
    {
        #sh -c "$(cleartool ls $1 | sed  -e '/CHECKEDOUT/{s/\(.*\)@@\(.*CHECKEDOUT\).from.\(.*\) *Rule:.*/echo vimdiff \1 \1@@\3/g;;n;}' -e 's/\(.*\)\/\([0-9]\+\)[ \t]*.*/echo vimdiff \1\/\2 \1\/$( echo \2-1|bc) /g'|sh)"
        sh -c "$(cleartool ls -short $1 | sed  -e '/CHECKEDOUT/{s/\(.*\)@@\(.*\)CHECKEDOUT/echo vimdiff \1 \1@@\2LATEST/g;;n;}' -e 's/\(.*\)\/\([0-9]\+\)[ \t]*.*/echo vimdiff \1\/\2 \1\/LATEST /g'|sh)"
    }


    function cdiff()
    {
        #cleartool ls $1 | sed  -e '/CHECKEDOUT/{s/\(.*\)@@\(.*CHECKEDOUT\).from.\(.*\) *Rule:.*/echo vimdiff \1 \1@@\3/g;;n;}' -e 's/\(.*\)\/\([0-9]\+\)[ \t]*.*/echo vimdiff \1\/\2 \1\/$( echo \2-1|bc) /g'|sh
        cleartool ls -short $1 | sed  -e '/CHECKEDOUT/{s/\(.*\)@@\(.*\)CHECKEDOUT/echo vimdiff \1 \1@@\2LATEST/g;;n;}' -e 's/\(.*\)\/\([0-9]\+\)[ \t]*.*/echo vimdiff \1\/\2 \1\/$( echo \2-1|bc) /g'|sh
    }

    function cdiffl()
    {
        #cleartool ls $1 | sed  -e '/CHECKEDOUT/{s/\(.*\)@@\(.*CHECKEDOUT\).from.\(.*\) *Rule:.*/echo vimdiff \1 \1@@\3/g;;n;}' -e 's/\(.*\)\/\([0-9]\+\)[ \t]*.*/echo vimdiff \1\/\2 \1\/$( echo \2-1|bc) /g'|sh
        cleartool ls -short $1 | sed  -e '/CHECKEDOUT/{s/\(.*\)@@\(.*\)CHECKEDOUT/echo vimdiff \1 \1@@\2LATEST/g;;n;}' -e 's/\(.*\)\/\([0-9]\+\)[ \t]*.*/echo vimdiff \1\/\2 \1\/LATEST /g'|sh
    }

    alias bld="gmake OPTIMIZER=-g"

    alias rd="cd /build/rrout"
    alias wd="cd /build/webrev/rrout"
    #PATH="$PATH:/opt/onbld/bin:/usr/rational/local/bin:/usr/atria/bin/"
    pathappend /opt/onbld/bin
    pathappend /usr/rational/local/bin
    pathappend /usr/atria/bin/
fi

if [ "$BASH_SCREEN_SETTINGS" == "yes" ];then
if [ "$BASH_DEBUG_SETTINGS" == "yes" ];then echo "Setting SCREEN_SETTINGS=$BASH_SCREEN_SETTINGS ........"; fi
#echo "${PWD}" > ${HOME}/.screen_pwd_${STY#*.}
alias scrn-ls="screen -ls"

function scrn-a()
{
    count=$(screen -ls | grep -c -w $1)
    if [ $# == 0  ]; then
        if [ $count -gt 0 ];then
            screen -ls
            return
        fi
    fi
    screen -x $1
}

function scrn-creat()
{
    echo $1
    count=$(screen -ls | grep -c -w $1)
    echo $count
    if [ $count -gt 0 ];then
        screen -ls
    else
        screen -S $1
    fi

}
fi

if [ "$BASH_LANG_SETTINGS" == "yes" ];then
if [ "$BASH_DEBUG_SETTINGS" == "yes" ];then echo "Setting LANG_SETTINGS=$BASH_LANG_SETTINGS ........"; fi
#Language Settings
export LC_ALL="en_US.UTF-8"
export LANG="en_US.UTF-8"
export LC_CTYPE="en_US.UTF-8"

export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export LANGUAGE=en_US.UTF-8
fi

if [ "$BASH_BITBAKE_SETTINGS" == "yes" ];then
if [ "$BASH_DEBUG_SETTINGS" == "yes" ];then echo "Setting LANG_SETTINGS=$BASH_LANG_SETTINGS ........"; fi
    source ${HOME}/reditor/bash/.bashrc_bitbake_autocomplete
fi

if [ "$BASH_USER_EXTENDED_ALIAS_SETTINGS" == "yes" ];then
if [ "$BASH_DEBUG_SETTINGS" == "yes" ];then echo "Setting USERALIAS_SETTINGS=$BASH_USERALIAS_SETTINGS ........"; fi

alias resource='source ~/.bashrc && echo "✅ Done"'
## pass options to free ##
alias meminfo='free -m -l -t'
## get top process eating memory
alias psmem='ps auxf | sort -nr -k 4'
alias psmem10='ps auxf | sort -nr -k 4 | head -10'
## get top process eating cpu ##
alias pscpu='ps auxf | sort -nr -k 3'
alias pscpu10='ps auxf | sort -nr -k 3 | head -10'
## Get server cpu info ##
alias cpuinfo='lscpu'


alias disksize="df -Th --total"
#copy with progress bar
alias cpv='rsync -ah --info=progress2'
#mounted points
alias mntpt='mount | grep -E ^/dev | column -t'
#list size of directory content
alias listdiruse='du -sh * | sort -h'
alias diruse="du -sh"

# list the name of the process matched with pgrep
alias pgrep='pgrep -l'
# print the path with each directory separated by a newline
alias path='echo -e ${PATH//:/\\n}'

# FIND: quickly find files and directory
alias ff='find . -type f -name'
alias fd='find . -type d -name'

function srch {
    if [ -z "$1" ]; then
        echo "Usage : srch <string|regx>"
        return 1;
    fi
    echo "Searching $1 in [${PWD}]"
    echo "------------------------------------------------------------------"
    find . -name $1 -print
    echo "------------------------------------------------------------------"
    echo "✅ Done"
}

function srchstr {
    if [ -z "$1" ]; then
        echo "Usage : srchstr <file type(Ex.*.cc)> <string|regx>"
        return 1;
    fi
    echo "Searching string $1 in [${PWD}]"
    echo "------------------------------------------------------------------"
    find . -name "$1" | xargs grep -li $2;
    echo "------------------------------------------------------------------"
    echo "✅ Done"
}

function cdir () {
    mkdir -p $1
    cd $1
}

function extract {
 if [ -z "$1" ]; then
    # display usage if no parameters given
    echo "Usage: extract <path/file_name>.<zip|rar|bz2|gz|tar|tbz2|tgz|Z|7z|xz|ex|tar.bz2|tar.gz|tar.xz>"
    echo "       extract <path/file_name_1.ext> [path/file_name_2.ext] [path/file_name_3.ext]"
    return 1
 else
    for n in $@
    do
      if [ -f "$n" ] ; then
          case "${n%,}" in
            *.tar.bz2|*.tar.gz|*.tar.xz|*.tbz2|*.tgz|*.txz|*.tar) 
                         tar xvf "$n"       ;;
            *.lzma)      unlzma ./"$n"      ;;
            *.bz2)       bunzip2 ./"$n"     ;;
            *.rar)       unrar x -ad ./"$n" ;;
            *.gz)        gunzip ./"$n"      ;;
            *.zip)       unzip ./"$n"       ;;
            *.z)         uncompress ./"$n"  ;;
            *.7z|*.arj|*.cab|*.chm|*.deb|*.dmg|*.iso|*.lzh|*.msi|*.rpm|*.udf|*.wim|*.xar)
                         7z x ./"$n"        ;;
            *.xz)        unxz ./"$n"        ;;
            *.exe)       cabextract ./"$n"  ;;
            *)
                         echo "extract: '$n' - unknown archive method"
                         return 1
                         ;;
          esac
      else
          echo "'$n' - file does not exist"
          return 1
      fi
    done
 fi
}

function extract1 () {
      if [ -f $1 ] ; then
          case $1 in
              *.tar.xz)    tar xvJf $1    ;;
              *.tar.bz2)   tar xvjf $1    ;;
              *.tar.gz)    tar xvzf $1    ;;
              *.bz2)       bunzip2 $1     ;;
              *.rar)       unrar e $1     ;;
              *.gz)        gunzip $1      ;;
              *.tar)       tar xvf $1     ;;
              *.tbz2)      tar xvjf $1    ;;
              *.tgz)       tar xvzf $1    ;;
              *.apk)       unzip $1       ;;
              *.epub)      unzip $1       ;;
              *.xpi)       unzip $1       ;;
              *.zip)       unzip $1       ;;
              *.war)       unzip $1       ;;
              *.jar)       unzip $1       ;;
              *.Z)         uncompress $1  ;;
              *.7z)        7z x $1        ;;
              *)           echo "don't know how to extract '$1'..." ;;
          esac
      else
          echo "'$1' is not a valid file!"
      fi
}

function repeat()
{
    if [ -z "$1" ]; then
        echo "Usage: repeat <number of time> <command>"
        return 1
    fi
    echo "$@"
    local i max
    max=$1; shift;
    for ((i=1; i <= max ; i++)); do  # --> C-like syntax
        echo "----------------------------------------------------------"
        eval "$@";
        sleep 1
    done
}

# print the last ten modified files in the specified directory
function last {
    ls -lt $1 | head
}
# shortcut for recursively grepping
function gr {
    grep -r $1 .
}

function myip()
{
    extIp=$(dig +short myip.opendns.com @resolver1.opendns.com)

    printf "Wireless IP: "
    MY_IP=$(/sbin/ifconfig wlp4s0 | awk '/inet/ { print $2 } ' |
      sed -e s/addr://)
    echo ${MY_IP:-"Not connected"}


    printf "Wired IP: "
    MY_IP=$(/sbin/ifconfig enp0s25 | awk '/inet/ { print $2 } ' |
      sed -e s/addr://)
    echo ${MY_IP:-"Not connected"}

    echo ""
    echo "WAN IP: $extIp"

}

fi

if [ "$BASH_DEBUG_SETTINGS" == "yes" ];then echo "Setting ORG_SETTINGS=$BASH_ORG_SETTINGS ........"; fi
if [ "$BASH_ORG_SETTINGS" == "brcd" ];then
source ${HOME}/reditor/bash/.bashrc_custom_profile_user_brcd
elif [ "$BASH_ORG_SETTINGS" == "pn" ];then
source ${HOME}/reditor/bash/.bashrc_custom_profile_user_pn
elif [ "$BASH_ORG_SETTINGS" == "fnc" ];then
source ${HOME}/reditor/bash/.bashrc_custom_profile_user_fnc
fi

if [ "$BASH_DEBUG_SETTINGS" == "yes" ];then echo "Setting Vim color scheme ........"; fi
export VIMCOLOR=LIGHT
if [ ! -z $STY ];then
    export VIMCOLOR=DARK
elif [ "$TERM_PROGRAM" == "vscode" ];then
    export VIMCOLOR=DARK
fi

function h_tmux()
{
    echo "usage"
    echo "-----------------------------------------------------"
    echo " tmux                         - start new"
    echo " tmux new -s myname  A: ts    - start new with name"
    echo " tmux a                       - attach"
    echo " tmux a -t myname    A: ta    - attach to session"
    echo " tmux ls             A: t-ls  - list sessions"
    echo " tmux kill-session -t myname  - kill session"
    echo "====================================================="
    echo " CHEAT SHEET (Prefix: C-a)"
    echo "====================================================="
    echo " Prefix C-a   - pass-through"
    echo " Prefix C-r   - reload tmux.conf"
    echo " Prefix C-s   - choose session"
    echo " Prefix d     - detach from session"
    echo " Prefix c     - create window"
    echo " Prefix r     - rename window"
    echo " Prefix w     - list windows"
    echo " Prefix n     - next window"
    echo " Prefix p     - previous window"
    echo " Prefix space - last window"
    echo " Prefix 1-9   - goto window n"
    echo " Prefix s     - show pane numbers"
    echo " Prefix q     - quit pane"
    echo " Prefix ?     - list all bindings"
    echo " Prefix :     - command-line"
    echo " Prefix |     - horizontal split"
    echo " Prefix -     - vertical split"
    echo " Prefix C-c   - copy mode"
    echo " Prefix C-v   - paste"
    echo " Prefix PgUp  - scroll mode"
    echo "====================================================="
cat<<-EOF
    Copy and Paste in Tmux:
    -----------------------
        Enter copy mode: <prefix>+[
        Start copy: <Space>
        Copy text: press UP or Down Key
        End copy : <Enter>
        Paste text: <prefix>+]
        If you wnat to save : <prefix>+: then : save-buffer ~/out_file
    Multiple Pane Synchronization (command on multiple screen)
    ----------------------------------------------------------
        <prefix> : then :setw synchronize-panes
        Note: Thos toggles the mode so same command to come out

EOF
}

function h_setup(){
cat<<-EOF
        Command    Descreption
        ---------- --------------------------------------------------------------------
        ld         load image from /build/rrout/work/main<>/nvOS/usr/src( ld <1....3> )
        loadl      load linux image ( loadl <work/main5/nvOS/usr/src> )
        loads      load solaris image ( loads <work/main5/nvOS/usr/src>  )
        ldwkspce   load image from /build/rrout/work/main/nvOS/usr/src
        zo         go to zone/lxc (zo <lxc name> )
        zlist      list zone/lxc s
        zgo        go to zone/lxc
        nv         nvOS services options ( nv s -status, nv sp -stop, nv r -restart )
        mymnt      mount /build/rrout from $BUILD_MECHIENE
        myumnt     unmount /build/rrout from $BUILD_MECHIENE
        m-mnt      mount /build2 from $BUILD_MECHIENE
        m-umnt     unmount /build2 from $BUILD_MECHIENE
        nvosgdb    gdb --pid "'pidof nvOSd'"
        h_tcpdump  help tcpdump
        h_gdb      help gdb
        h_dtrace   help dtrace
        zpath      lxc rootfs path
        mkenv      install gmake and hg
EOF
}

function h_gdb(){
    cat ${HOME}/reditor/bash/bash_help/bash_gdb_help.txt
cat <<-EOF
        gdb -q -ex "set height 0" -ex "info sources" -ex quit /usr/sbin/pim-sm-d
        (gdb) set substitute-path /build/rrout/ /media/cartman/
        (gdb)
        +CFLAGS         += -fno-inline-small-functions
        -----------------
        Run gdb cmdline : gdb --args executablename arg1 arg2 arg3
        -----------------
        Run gdb nvOS fron begin:
        #gdb /usr/sbin/nvOSd
        #(gdb) run -l /var/nvOS/log/nvOSd.log -d 2
        --- "-b" detaches it and runs it in the background hence exclude -b
        ------------------
EOF
}

function h_tcpdump() {
    cat ${HOME}/reditor/bash/bash_help/bash_tcpdump_help.txt
cat<<-EOF
        https://danielmiessler.com/study/tcpdump/
        tcpdump -i eth0
        tcpdump -ttttnnvvS
        tcpdump host 1.2.3.4
        tcpdump -nnvXSs 0 -c1 icmp
        tcpdump src 2.3.4.5
        tcpdump dst 3.4.5.6
        tcpdump net 1.2.3.0/24
        tcpdump port 3389
        tcpdump src port 1025
        tcpdump icmp
        tcpdump ip6
        tcpdump portrange 21-23
        tcpdump less 32
        tcpdump greater 64
        tcpdump <= 128
        tcpdump port 80 -w capture_file
        tcpdump -r capture_file
        tcpdump -nnvvS src 10.5.2.3 and dst port 3389
        tcpdump -nvX src net 192.168.0.0/16 and dst net 10.0.0.0/8 or 172.16.0.0/16
        tcpdump dst 192.168.0.2 and src net and not icmp
        tcpdump -vv src mars and not dst port 22
        tcpdump 'src 10.0.2.4 and (dst port 3389 or 22)'
        tcpdump 'tcp[tcpflags] == tcp-syn'
        tcpdump 'ip[8] < 10' :- PACKETS WITH A TTL LESS THAN 10
EOF
}



function h_dtrace() {
    cat ${HOME}/reditor/bash/bash_help/bash_dtrace_help.txt
cat<<-EOF
                dtrace -F -n 'pid6120:a.out::entry/tid == 6978/{}'
                dtrace -Z -F -n 'fbt::port_show*:entry/execname == "nvOSd"/{}'
                dtrace -F -n 'pid6120:a.out:nvOS_count_command:entry/tid == 6978/{ustack();}'

                dtrace -n 'syscall:::entry {@[probefunc]=count();}'
                dtrace -n 'syscall::ioctl:entry {@[execname]=count();}'
                dtrace -n 'syscall::ioctl:entry /execname =="nvOSd"/ {@[ustack()]=count();}'
                /opt/DTT/Bin/iotop
                /opt/DTT/Bin/iosnoop -Deg
EOF
}


function h_gtags() {
    cat ${HOME}/reditor/bash/bash_help/bash_gtags_help.txt
cat<<-EOF
        ----------------------
        GTAGS COMMANDS
        ----------------------
        Command    Descreption
        ---------- --------------------------------------------------------------------
        gtags      Create GRATS Database in current Directory

        ----------------------
        GTAGS VIM COMMANDS
        ----------------------
        Command    Descreption
        ---------- --------------------------------------------------------------------
        <C-|>      Go to Defination
        <C-R>      Lookup Reference
        <C-E>      Go to Defination in left hand
        <C-S>      Local symbol reference
        <C-G>      Gtags raw string search [STRING-PATTERN]
        <C-D>      Open Navigation Path
        <C-T>      Return to previous tag
        <C-X><C-X> Open reference          [X-PARTEEN]
        <C-F><C-F> kg search               [K-PATTERN]
        <C-Y><C-Y> Ack search              [ACK-PATTREN]
        <C-LMouse> Mouse open Defination
        <C-R><C-R> Open Reference          [R-PATTERN}
        <C-G><C-G> Gtags grep search       [G-PARTTEN]
        <C-P><C-P> Open File Path
        <C-S><C-S> Searc sub string        [SUB-PATTERN]
        <C-F><C-R> Gtags search and replace
        <C-F><C-L> Gtags view cursor file
        <C-X><C-X> Search Parten Reference
EOF
}

function h_ctags() {
    cat ${HOME}/reditor/bash/bash_help/bash_ctags_help.txt
}

function h_myvim() {
    cat ${HOME}/reditor/bash/bash_help/bash_vim_help.txt
cat<<-EOF
	------------------------------
	MY VIM BINDINGS
	------------------------------
	Command    Descreption
	---------- --------------------------------------------------------------------
	<F1>       Save File
	<F2>       Quit
	<F3>       Update Gtags DataBase
	<F4>       Toggle Paste Mode
	<F5>       Clearcase Checkout
	<F6>       Toggle Tab and Space Marking(:ToggleSpaceHi)
	<F7>       Clearcsse Update
	<F8>       Clearcase Undo Checkout
	<F9>       Go To Next Diff (In Diff Mode)
	<F10>      Paste Diff in Other Window (In Diff Mode)
	<F11>      Toggle TagList
	<C-F><C-H> Insert .c File Header
	<C-F><C-U> Insert Function Header
	<C-F><C-E> Align Equal
	<C-J>      Full Find And Replace
	<C-K>      Line Find and Replace
	<C-L>      Select Find And Replace
	<C-@>      Highlight Word
	<C-_>      Highlight Word Alt
	<C-N>      Paste Cycle Next
	<C-P>      Paste Cycle Previous
	<C-F>      Load Current Words Find
	<C-D>      Load Current Words Gtags
	<C-C>      Add Comment
	<C-X>      Remove Comment

	:StripWhitespace Strip The ending White Spaces

	:SignifyToggle   Toggle Mercurial Diff Bar
	:SignifyToggleHighlight  Toggle Better Mercurial Highlights
	:SignifyDiff     Open Mercurial Diff in a Tab (tabedit window)

	:tabedit         Edit In Diffrent Tab

EOF
}

function h_hg() {
    cat ${HOME}/reditor/bash/bash_help/bash_hg_help.txt
cat<<-EOF
	Command                Descreption
	---------------------- ------------------------------------------
	hg log | more          Show list of changesets
	hg log -v -r <change>  Show changeset descreption
	hg id -i               Show current version of the branch(hg log -v -r "hg id -i")
	hg log -p -r <change>  Get the changeset code diff (hg log -p -r 1)
	hg summary             Show summery of current view
	hg update -r <change>  Get the view to the change set (hg update -r 1)
	hg diff -r <ch> -r <ch>Get diff between two changeset
	hg diff -c <change>    Get the changeset code diff in a patch format
	hg update --clean      Cancel an uncommitted merge and lose changes
	hg update tip          Update work to match tip
EOF
}

function h_git() {
    cat ${HOME}/reditor/bash/bash_help/bash_git_help.txt
}

function h_screen() {
    cat ${HOME}/reditor/bash/bash_help/bash_screen_help.txt
}

function h_linux_cmd() {
    cat ${HOME}/reditor/bash/bash_help/bash_linux_cmd_help.txt
}

function h_bitbake() {
    cat ${HOME}/reditor/bash/bash_help/bash_bitbake_help.txt
}

function h_dbg() {
    cat ${HOME}/reditor/bash/bash_help/bash_dbg_cmd_help.txt
}

function h_core() {
    cat ${HOME}/reditor/bash/bash_help/bash_core_help.txt
}

function h_rdebug() {
    cat ${HOME}/reditor/bash/bash_help/bash_rdebug_cmd_help.txt
}

function h_alias() {
    cat ${HOME}/reditor/bash/bash_help/bash_alias_help.txt
}
function h_net() {
    cat ${HOME}/reditor/bash/bash_help/bash_net_cmd_help.txt
}



