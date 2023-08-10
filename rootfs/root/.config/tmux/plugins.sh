#!/usr/bin/env bash
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
##@Version           :  202207042123-git
# @Author            :  Jason Hempstead
# @Contact           :  jason@casjaysdev.pro
# @License           :  LICENSE.md
# @ReadME            :  install_plugins --help
# @Copyright         :  Copyright: (c) 2022 Jason Hempstead, Casjays Developments
# @Created           :  Saturday, Jul 09, 2022 15:22 EDT
# @File              :  install_plugins
# @Description       :
# @TODO              :
# @Other             :
# @Resource          :
# @sudo/root         :  no
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
TMUX_HOME="${TMUX_HOME:-$HOME/.config/tmux}"
TMUX_SHARE_DIR="${TMUX_SHARE_DIR:-$HOME/.local/share/tmux}"
TMUX_PLUGIN_MANAGER_PATH="${TMUX_PLUGIN_MANAGER_PATH:-$TMUX_SHARE_DIR/plugins}"
export TMUX_HOME TMUX_PLUGIN_MANAGER_PATH TMUX_SHARE_DIR
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
if [ -d "$TMUX_PLUGIN_MANAGER_PATH/tpm/.git" ]; then
  git -C "$TMUX_PLUGIN_MANAGER_PATH/tpm" pull -qq &>/dev/null
else
  [ -d "$TMUX_PLUGIN_MANAGER_PATH/tpm" ] && rm -Rf "$TMUX_PLUGIN_MANAGER_PATH/tpm"
  git clone "https://github.com/tmux-plugins/tpm" "$TMUX_PLUGIN_MANAGER_PATH/tpm" &>/dev/null
fi
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
if [ -x "$TMUX_PLUGIN_MANAGER_PATH/tpm/bin/install_plugins" ]; then
  "$TMUX_PLUGIN_MANAGER_PATH/tpm/bin/install_plugins"
fi
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
mkdir -p "$TMUX_SHARE_DIR/resurrect"
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
if [ -f "$TMUX_HOME/resurrect" ]; then
  ln -sf "$TMUX_HOME/resurrect" "$TMUX_SHARE_DIR/resurrect/last"
fi
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
if [ -f "$TMUX_PLUGIN_MANAGER_PATH/tpm/tpm" ] && [ -f "$TMUX_SHARE_DIR/resurrect/last" ]; then
  echo "Install completed"
  exitCode=0
else
  echo "Install failed"
  exitCode=1
fi
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
exit ${exitCode:-$?}
