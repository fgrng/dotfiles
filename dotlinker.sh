#!/bin/bash

SCRIPTDIR="$( cd "$( dirname "${BASH_SOURCE[ 0]}" )" && pwd )"
cd ${SCRIPTDIR}

echo "Update Repository."
git pull

echo ""
echo "Link dotfiles."
for file in $(ls -l | awk 'NR!=1 && !/^d/ {print $NF}') ; 
do
  ln -vfs /home/${USER}/dotfiles/${file} /home/${USER}/.${file} 
done

echo ""
echo "Link host-specific dotfiles"
ln -vfs /home/${USER}/dotfiles/i3/config.${HOST} /home/${USER}/dotfiles/i3/config
unlink /home/${USER}/.xsession
ln -vfs /home/${USER}/dotfiles/xsession.${HOST} /home/${USER}/.xsession

echo ""
echo "Link dotfolders."
ln -Tsfv /home/${USER}/dotfiles/i3/ /home/${USER}/.i3
ln -Tsfv /home/${USER}/dotfiles/emacs.d/ /home/${USER}/.emacs.d
ln -Tsfv /home/${USER}/dotfiles/elisp/ /home/${USER}/.elisp
ln -Tsfv /home/${USER}/dotfiles/pentadactyl/ /home/${USER}/.pentadactyl
ln -Tsfv /home/${USER}/dotfiles/zsh.d/ /home/${USER}/.zsh.d
mv /home/${USER}/.ssh /home/${USER}/.ssh_bak
unlink /home/${USER}/.ssh
ln -Tsfv /home/${USER}/dotfiles/ssh/ /home/${USER}/.ssh

rm /home/${USER}/.README
rm /home/${USER}/.dotlinker.sh

echo ""
echo "Done."
