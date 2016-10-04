# =====================================================================
# === ZShell Config File ==============================================
# =====================================================================
# --- Filename:     .zshrc
# --- Author:       Fabian Grünig
# ---               gruenig@posteo.de
# --- Description:  config file for zsh
# ---
# ---

# enable and configure the history
  setopt append_history
  setopt SHARE_HISTORY
  HISTFILE="${HOME}/tmp/.zsh_history"
  HISTSIZE=1000
  SAVEHIST=1000
  export HISTIGNORE="&:ls:[bf]g:exit:reset:clear:cd:cd ..:cd.."
  setopt HIST_IGNORE_ALL_DUPS
  setopt HIST_IGNORE_SPACE
  setopt HIST_REDUCE_BLANKS

# Prompts for confirmation after 'rm *' etc
  setopt RM_STAR_WAIT

# Background processes (does this work?)
  # setopt NO_HUP
  setopt AUTO_CONTINUE
  unsetopt BG_NICE
 
# timeout on root shell for "security"
  if [[ $UID == 0 ]]; then
    TMOUT=180
  fi

# No fu**ing Beeping
  setopt No_Beep

# URLsymbol escaping
  autoload -U url-quote-magic
  zle -N self-insert url-quote-magic

# Pos1 und END 
  bindkey '\e[7~' beginning-of-line
  bindkey '\e[8~' end-of-line
  bindkey '^[[3~' delete-char
  bindkey '^[3;5~' delete-char

# ---------------------------------------------------------------------
# --- Completion ------------------------------------------------------
# ---------------------------------------------------------------------

unsetopt menu_complete # do not autoselect the first completion entry
unsetopt flowcontrol

setopt auto_menu # show completion menu on succesive tab press
setopt complete_in_word
setopt always_to_end

# Weniger Wordchars
# Ctrl-Backspace respektiert "/"
  export WORDCHARS='*?_[]~=&;!#$%^(){}<>'

# shift tab + complete-hist
  bindkey "^[[Z" reverse-menu-complete
  bindkey '^[[A' up-line-or-search
  bindkey '^[[B' down-line-or-search

# case insensitive
  zstyle ':completion:*' matcher-list 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
  unset CASE_SENSITIVE

  zstyle ':completion:*' list-colors ''

# processes
  zstyle ':completion:*:*:*:*:*' menu select
  zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#) ([0-9a-z-]#)*=01;34=0=01'
  zstyle ':completion:*:*:*:*:processes' command "ps -u `whoami` -o pid,user,comm -w -w"
  
# load completion / completer
  type compinit &>/dev/null || { autoload -U compinit && compinit }
  zstyle ':completion:*' completer _complete _correct
  zstyle ':completion:*:expand:*' tag-order all-expansions

# Cache
  zstyle ':completion:*' use-cache on
  zstyle ':completion:*' cache-path /tmp/.zshcache

# Style
  zstyle ':completion:*:default' list-colors "${(s.:.)LS_COLORS}"
  zstyle ':completion:*' menu select=2

# Errors
  zstyle -e ':completion:*:approximate:*' max-errors 1 numeric
  zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# Formatting / messages
  zstyle ':completion:*' verbose yes
  zstyle ':completion:*:descriptions' format '%B%d%b'
  zstyle ':completion:*:messages' format '%d'
  zstyle ':completion:*:warnings' form at 'No matches for: %d'
  zstyle ':completion:*:corrections' format '%B%d (errors: %e)%b'
  zstyle ':completion:*' group-name ''

# zstyle magical kill menu
  zstyle ':completion:*:*:kill:*' menu yes select
  zstyle ':completion:*:kill:*' force-list always
  zstyle ':completion:*:*:kill:*:processes' list-colors "=(#b) #([0-9]#)*=36=31"

# hosts
  zstyle ':completion:*:hosts' hosts $hostnames

# ---------------------------------------------------------------------
# --- Key Bindings ----------------------------------------------------
# ---------------------------------------------------------------------

bindkey -e
  
# ---------------------------------------------------------------------
# --- Appereance ------------------------------------------------------
# ---------------------------------------------------------------------

# load colors
  autoload -U colors
  colors

# Define colors
  # Forground
  fg_black=%{$'\e[0;30m'%}
  fg_red=%{$'\e[0;31m'%}
  fg_green=%{$'\e[0;32m'%}
  fg_brown=%{$'\e[0;33m'%}
  fg_blue=%{$'\e[0;34m'%}
  fg_purple=%{$'\e[0;35m'%}
  fg_cyan=%{$'\e[0;36m'%}
  fg_lgray=%{$'\e[0;37m'%}
  fg_dgray=%{$'\e[1;30m'%}
  fg_lred=%{$'\e[1;31m'%}
  fg_lgreen=%{$'\e[1;32m'%}
  fg_yellow=%{$'\e[1;33m'%}
  fg_lblue=%{$'\e[1;34m'%}
  fg_pink=%{$'\e[1;35m'%}
  fg_lcyan=%{$'\e[1;36m'%}
  fg_white=%{$'\e[1;37m'%}
  # Background
  bg_red=%{$'\e[0;41m'%}
  bg_green=%{$'\e[0;42m'%}
  bg_brown=%{$'\e[0;43m'%}
  bg_blue=%{$'\e[0;44m'%}
  bg_purple=%{$'\e[0;45m'%}
  bg_cyan=%{$'\e[0;46m'%}
  bg_gray=%{$'\e[0;47m'%}
  # Attributes
  at_normal=%{$'\e[0m'%}
  at_bold=%{$'\e[1m'%}
  at_italics=%{$'\e[3m'%}
  at_underl=%{$'\e[4m'%}
  at_blink=%{$'\e[5m'%}
  at_outline=%{$'\e[6m'%}
  at_reverse=%{$'\e[7m'%}
  at_nondisp=%{$'\e[8m'%}
  at_strike=%{$'\e[9m'%}
  at_boldoff=%{$'\e[22m'%}
  at_italicsoff=%{$'\e[23m'%}
  at_underloff=%{$'\e[24m'%}
  at_blinkoff=%{$'\e[25m'%}
  at_reverseoff=%{$'\e[27m'%}
  at_strikeoff=%{$'\e[29m'%}

# Define prompt
  setopt prompt_subst
  autoload -Uz vcs_info
  autoload -U colors && colors

  zstyle ':vcs_info:*' actionformats \
      '%F{5}(%f%s%F{5})%F{3}-%F{5}[%F{2}%b%F{3}|%F{1}%a%F{5}]%f '
  zstyle ':vcs_info:*' formats       \
      '%F{5}(%f%s%F{5})%F{3}-%F{5}[%F{2}%b%F{5}]%f '
  zstyle ':vcs_info:(sv[nk]|bzr):*' branchformat '%b%F{1}:%F{3}%r'
  
  zstyle ':vcs_info:*' enable git cvs svn hg

  vcs_info_wrapper() {
      vcs_info
      if [ -n "$vcs_info_msg_0_" ]; then
          echo "%{$fg[grey]%}${vcs_info_msg_0_}%{$reset_color%}$del"
      fi
  }

# Define titlebar
  function title() {
    # escape '%' chars in $1, make nonprintables visible
    a=${(V)1//\%/\%\%}
    
    # Truncate command, and join lines.
    a=$(print -Pn "%40>...>$a" | tr -d "\n")
    
    case $TERM in
      screen)
        print -Pn "\ek$a:$3\e\\"      # screen title (in ^A")
        ;;
      xterm*|rxvt*)
	print -Pn "\e]2;$2 | $3\a" # plain xterm title
	;;
    esac
  }

  # precmd is called just before the prompt is printed
  function precmd() {
    title "Dir" "zsh" "%55<...<%~"
  }

  # preexec is called just before any command line is executed
  function preexec() {
    title "$1" "zsh" "%35<...<%~"
  }

  eval `dircolors -b ~/.dircolors` 

# bell after cmd
  bellchar=''
  zle-line-init () { echo -n "$bellchar" }
  zle -N zle-line-init

# ---------------------------------------------------------------------
# --- Global Aliases --------------------------------------------------
# ---------------------------------------------------------------------

# These do not have to be at the beginning of the command line.
#  alias -g '...'='../../'
#  alias -g '....'='../../../'

# Better:
  # Quick ../../..
  rationalise-dot() {
      if [[ $LBUFFER = *.. ]]; then
          LBUFFER+=/..
      else
          LBUFFER+=.
      fi
  }
  zle -N rationalise-dot
  bindkey . rationalise-dot

  alias -g BG='& disown'
  alias -g G='|grep'
  alias -g T='|tail'

# ---------------------------------------------------------------------
# --- Aliases ---------------------------------------------------------
# ---------------------------------------------------------------------

# listing stuff
  alias ls="ls --color --group-directories-first"
  alias ll='ls -lh'                 # display more information
  alias lh='ls -lrAh  .*(.)'        # only show dot-files
  alias la='ls -lrAh'               # show all files
  alias ld='ls -ldrh *(/)'          # only show directories
  alias lsnew="ls -rl *(D.om[1,10])"        # display the newest files
  alias lsold="ls -rtlh *(D.om[1,10])"      # display the oldest files

  alias mkdir='mkdir -p'                    # mkdir full path
  alias pp='popd'
  alias pu='pushd'
  alias cb='cd -'

function gi() {
    gitdir=$(git rev-parse --show-cdup)
    if [ -d ${gitdir}.git ]
    then
        echo $1 >> ${gitdir}.gitignore
    fi
}

# alias to avoid making mistakes:
  alias cd..="cd .."

# stuff
  alias df="df -h"
  alias psgrep="ps uax | grep "
  alias bc="bc -l"
  alias cl="clear"
  alias top='htop'

# ---------------------------------------------------------------------
# --- Local -----------------------------------------------------------
# ---------------------------------------------------------------------

# local config
  source ${HOME}/.zsh.d/${HOST}.zshrc

# ---------------------------------------------------------------------
# --- Plugins -----------------------------------------------------------
# ---------------------------------------------------------------------

# Path to plugin folder. (oh-my-zsh)
export ZSH=$HOME/.zsh.d/

is_plugin() {
    local base_dir=$1
    local name=$2
    test -f $base_dir/plugins/$name/$name.plugin.zsh \
	|| test -f $base_dir/plugins/$name/_$name
}

# load plugins: function path
for plugin ($plugins); do
    if is_plugin $ZSH $plugin; then
	fpath=($ZSH/plugins/$plugin $fpath)
    fi
done

# Save the location of the current completion dump file.
if [ -z "$ZSH_COMPDUMP" ]; then
    ZSH_COMPDUMP="${ZDOTDIR:-${HOME}}/.zcompdump-${HOST}-${ZSH_VERSION}"
fi

# Load and run compinit
autoload -U compinit
compinit -i -d "${ZSH_COMPDUMP}"

# load plugins: sources
for plugin ($plugins); do
    if [ -f $ZSH/plugins/$plugin/$plugin.plugin.zsh ]; then
	source $ZSH/plugins/$plugin/$plugin.plugin.zsh
    fi
done
