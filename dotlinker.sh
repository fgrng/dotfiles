#!/bin/bash

SCRIPTDIR="$( cd "$( dirname "${BASH_SOURCE[ 0]}" )" && pwd )"
THIS_HOST=`hostname`
THIS_USER=`whoami`
cd ${SCRIPTDIR}

echo "Update Repository."
git pull

echo ""
echo "Link dotfiles."
for file in $(ls -l | awk 'NR!=1 && !/^d/ {print $NF}') ; 
do
  ln -vfs /home/${THIS_USER}/dotfiles/${file} /home/${THIS_USER}/.${file} 
done

echo ""
echo "Link host-specific dotfiles"
echo "Hostname: ${THIS_HOST}"
ln -vfs /home/${THIS_USER}/dotfiles/i3/config.${THIS_HOST} /home/${THIS_USER}/dotfiles/i3/config
unlink /home/${THIS_USER}/.xsession
ln -vfs /home/${THIS_USER}/dotfiles/xsession.${THIS_HOST} /home/${THIS_USER}/.xsession

echo ""
echo "Link dotfolders."
ln -Tsfv /home/${THIS_USER}/dotfiles/i3/ /home/${THIS_USER}/.i3
ln -Tsfv /home/${THIS_USER}/dotfiles/emacs.d/ /home/${THIS_USER}/.emacs.d
ln -Tsfv /home/${THIS_USER}/dotfiles/elisp/ /home/${THIS_USER}/.elisp
ln -Tsfv /home/${THIS_USER}/dotfiles/pentadactyl/ /home/${THIS_USER}/.pentadactyl
ln -Tsfv /home/${THIS_USER}/dotfiles/zsh.d/ /home/${THIS_USER}/.zsh.d
mv /home/${THIS_USER}/.ssh /home/${THIS_USER}/.ssh_bak
unlink /home/${THIS_USER}/.ssh
ln -Tsfv /home/${THIS_USER}/dotfiles/ssh/ /home/${THIS_USER}/.ssh

rm /home/${THIS_USER}/.README
rm /home/${THIS_USER}/.dotlinker.sh

echo ""
echo "Done."
