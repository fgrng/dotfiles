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

  export PICVIEW="geeqie"

# ---------------------------------------------------------------------
# --- Apperiance ------------------------------------------------------
# ---------------------------------------------------------------------

  PROMPT="${fg_purple}%m${fg_green} %~${at_normal} %% "
  RPROMPT=$'$(vcs_info_wrapper)${fg_yellow}[%T]${at_normal}'

# ---------------------------------------------------------------------
# --- Aliases ---------------------------------------------------------
# ---------------------------------------------------------------------

  alias aptodate='~/src/aptodate-everything.zsh'

# drucken mit tiny
  alias prnt_norm='lp <'
  alias prnt_corner='lp -o StapleLocation=UpperLeft < '
  alias prnt_left='lp -o StapleLocation=LeftW < '
  alias prnt_top='lp -o StapleLocation=UpperW < '
  alias prnt_duplex2='lp -o Duplex=DuplexTumble < '
  alias prnt_duplex='lp -o Duplex=DuplexNoTumble < '
  alias prnt_duplex_corner='lp -o Duplex=DuplexNoTumble -o StapleLocation=UpperLeft < '