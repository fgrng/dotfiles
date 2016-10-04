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

# --- Plugins ---------------------------------------------------------

# define plugins
plugins=(git emacs bundler screen sudo rake-fast archlinux rsync zsh-navigation-tools zsh_reload)

# rvm completion
fpath=(${HOME}/.rvm/scripts/zsh/Completion/ $fpath)

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

# LaTeX

  alias texmake="latexmk -pdf -pdflatex='pdflatex -file-line-error -synctex=1'"
  alias texwatch="latexmk -pdf -pdflatex='pdflatex -file-line-error -synctex=1' -pvc"

# neo
  alias asdf="setxkbmap lv && xmodmap /home/fabian/.xmodmap_neo && xset -r 51"
  alias uiae="setxkbmap de && xset r 51"

# i hate cp!
  alias cp='rsync -ahP'
  alias scp='rsync -ahP'

# display
  alias vga_on='xrandr --output VGA1 --auto && xrandr --output VGA1 --left-of LVDS1'
  alias vga_same='xrandr --output VGA1 --auto && xrandr --output VGA1 --same-as LVDS1'
  alias vga_off='xrandr --output LVDS1 --auto --primary && xrandr --output VGA1 --off && i3-msg restart'

  alias hdmi_on='xrandr --output HDMI1 --auto && xrandr --output HDMI1 --left-of LVDS1'
  alias hdmi_off='xrandr --output HDMI1 --off && xrandr --output LVDS1 --auto'

# shortcuts
  alias mpl='mpv -no-input-joystick'

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

# archlinux upgrade 
  alias yaupg='yaourt -Syua' # Synchronize with repositories before upgrading packages (AUR packages too) that are out of date on the local system.
  alias yasu='yaourt --sucre' # Same as yaupg, but without confirmation
  alias yain='yaourt -S' # Install specific package(s) from the repositories
  alias yains='yaourt -U' # Install specific package not from the repositories but from a file
  alias yare='yaourt -R' # Remove the specified package(s), retaining its configuration(s) and required dependencies
  alias yarem='yaourt -Rns' # Remove the specified package(s), its configuration(s) and unneeded dependencies
  alias yarep='yaourt -Si' # Display information about a given package in the repositories
  alias yareps='yaourt -Ss' # Search for package(s) in the repositories
  alias yaloc='yaourt -Qi' # Display information about a given package in the local database
  alias yalocs='yaourt -Qs' # Search for package(s) in the local database
  alias yalst='yaourt -Qe' # List installed packages, even those installed from AUR (they're tagged as "local")
  alias yaorph='yaourt -Qtd' # Remove orphans using yaourt

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

# Music steuern
  alias raspi_webspot="chromium localhost:10000/rompr & disown & ssh pi@fanenet.dyndns.org -p 49153 -L 10000:127.0.0.1:80"

# Save Battery: Firefox
  alias ffsleep="pkill -SIGSTOP firefox"
  alias ffwake="pkill -SIGCONT firefox"
  alias chromesleep="pkill -SIGSTOP chrome"
  alias chromewake="pkill -SIGCONT chrome"

# Windows Terminal Server (urz hd)
	alias rurz="rdesktop -g 1366x768 -P -z -x l -r sound:off -d ad -u cx025 tsneu.ad.uni-heidelberg.de"

#	R, be quiet
	alias R="R --quiet"
