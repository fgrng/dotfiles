# =====================================================================
# === ZShell Config File ==============================================
# =====================================================================
# --- Filename:     .zshrc
# --- Author:       Fabian Grünig
# ---               fabian@mathphys.fsk.uni-heidelberg.de
# --- Description:  config file for zsh
# ---
# ---

# ---------------------------------------------------------------------
# --- Variables -------------------------------------------------------
# ---------------------------------------------------------------------

# export qtdir
  [ -d /usr/share/qt3 ] && export QTDIR=/usr/share/qt3
  [ -d /usr/share/qt4 ] && export QTDIR=/usr/share/qt4

# gnuPG agent
if [ -f "${HOME}/.gpg-agent-info" ]; then
    . "${HOME}/.gpg-agent-info"
    export GPG_AGENT_INFO
    export SSH_AUTH_SOCK
fi

# --- default applications---------------------------------------------

export EDITOR="emacsclient -c"
export BROWSER="iceweasel"
export PAGER="less"
export PICVIEW="feh"

export ALTERNATE_EDITOR="emacs"
export USE_EDITOR=$EDITOR
export VISUAL=$EDITOR
export MOVPLAY="mplayer"

# Path

PATH=$PATH:/home/fabian/.gem/ruby/2.1.0/bin

# ---------------------------------------------------------------------
# --- Apperiance  -----------------------------------------------------
# ---------------------------------------------------------------------

  if [[ $UID == 0 ]]; then
    PROMPT="${fg_lgray}[%T] ${fg_red}ROOT${fg_green} %~${at_normal} %% "
  else
    PROMPT="${fg_red}%m${fg_green} %~${at_normal} %% "
    RPROMPT=$'$(vcs_info_wrapper)${fg_yellow}[%T]${at_normal}'
  fi

# ---------------------------------------------------------------------
# --- Aliases ---------------------------------------------------------
# ---------------------------------------------------------------------

  rmtex () {
    find ./ -type f -regex '.*\.(aux|out)'
  }

  maketex () {
    pdflatex $1; 
    biber $1;
    pdflatex $1;
    rmtex;
  } 

# neo
  alias asdf="setxkbmap lv && xmodmap /home/fabian/.xmodmap_neo && xset -r 51"
  alias uiae="setxkbmap de && xset r 51"

# i hate cp!
  alias cp='rsync -ahP'
  alias scp='rsync -ahP'

# emacs shortcuts
  em () {
    emacsclient --alternate-editor="" -c $1 & disown
  }
  emt () {
    emacsclient --alternate-editor="" -nw -c $1
  }
  ems () {
    emacsclient --alternate-editor=""
  }

# display
  alias vga_on='xrandr --output VGA1 --auto && xrandr --output VGA1 --left-of LVDS1'
  alias vga_same='xrandr --output VGA1 --auto && xrandr --output VGA1 --same-as LVDS1'
  alias vga_off='xrandr --output LVDS1 --auto && xrandr --output VGA1 --off'

  alias hdmi_on='xrandr --output HDMI1 --auto && xrandr --output HDMI1 --left-of LVDS1'
  alias hdmi_off='xrandr --output HDMI1 --off && xrandr --output LVDS1 --auto'

# shortcuts
  alias mpl='mplayer -idx -msgcolor -nojoystick'

# debian upgrade
  # alias aptodate='sudo aptitude update && sudo aptitude safe-upgrade'
  # alias aptodate_everything='~/src/aptodate-everything.zsh'
  # alias apu='sudo aptitude update'
  # alias apup='sudo aptitude upgrade'
  # alias api='sudo aptitude install'
  # alias apri='sudo aptitude reinstall'
  # alias aps='sudo aptitude search'
  # alias apsh='sudo aptitude show'
  # alias apr='sudo aptitude remove'
  # alias app='sudo aptitude purge'
  # alias apc='sudo aptitude autoclean'

# mpd
  alias raspi_spot="ncmpcpp --host 192.168.2.112"
  alias raspi_mpd="ncmpcpp --host 192.168.2.112 --port 6611"
  # alias spotify="ncmpcpp --port 6600"
  alias ncmpc="ncmpcpp --port 6611"


# drucken mit tiny
  alias prnt_norm='ssh mp lp <'
  alias prnt_corner='ssh mp lp -o StapleLocation=UpperLeft < '
  alias prnt_left='ssh mp lp -o StapleLocation=LeftW < '
  alias prnt_top='ssh mp lp -o StapleLocation=UpperW < '
  alias prnt_duplex2='ssh mp lp -o Duplex=DuplexTumble < '
  alias prnt_duplex='ssh mp lp -o Duplex=DuplexNoTumble < '
  alias prnt_duplex_corner='ssh mp lp -o Duplex=DuplexNoTumble -o StapleLocation=UpperLeft < '
  alias prnt_cups='ssh mp firefox --no-remote localhost:631'

# screen
  alias scr='screen -X caption always "%{rw} * | %H * $LOGNAME | %{bw}%c %D |
 %{-}%-Lw%{rw}%50>%{rW}%n%f* %t %{-}%+Lw%<" '

# Dock-Mode
alias dockon="/home/fabian/src/dockon.sh"

# Music steuern
  alias raspi_webspot="chromium localhost:10000/rompr & disown & ssh pi@fanenet.dyndns.org -p 49153 -L 10000:127.0.0.1:80"

# Battety: Firefox

alias ffsleep="kill -SIGSTOP `pgrep firefox`"
alias ffwake="kill -SIGCONT `pgrep firefox`"