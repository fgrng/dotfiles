#!/usr/bin/env bash

SCRIPTDIR="$( cd "$( dirname "${BASH_SOURCE[ 0]}" )" && pwd )"
THIS_HOST=`hostname`
THIS_USER=`whoami`
cd ${SCRIPTDIR}

echo ""
echo "Update Repository."
git pull

echo ""
echo "Link dotfiles."
for file in $(ls -l | awk 'NR!=1 && !/^d/ {print $NF}') ; 
do
  ln -vfs ${SCRIPTDIR}/${file} ${HOME}/.${file} 
done

echo ""
echo "Link host-specific dotfiles"
echo "Hostname: ${THIS_HOST}"
ln -vfs ${SCRIPTDIR}/i3/config.${THIS_HOST} ${SCRIPTDIR}/i3/config

unlink ${HOME}/.xsession
ln -vfs ${SCRIPTDIR}/xsession.${THIS_HOST} ${HOME}/.xsession

unlink ${HOME}/.profile
ln -vfs ${SCRIPTDIR}/profile.${THIS_HOST} ${HOME}/.profile
ln -vfs ${SCRIPTDIR}/profile.${THIS_HOST} ${HOME}/.bash_profile
ln -vfs ${SCRIPTDIR}/profile.${THIS_HOST} ${HOME}/.zprofile

echo ""
echo "Link dotfolders."
ln -Tsfv ${SCRIPTDIR}/i3/ ${HOME}/.i3
ln -Tsfv ${SCRIPTDIR}/emacs.d/ ${HOME}/.emacs.d
ln -Tsfv ${SCRIPTDIR}/elisp/ ${HOME}/.elisp
ln -Tsfv ${SCRIPTDIR}/pentadactyl/ ${HOME}/.pentadactyl
ln -Tsfv ${SCRIPTDIR}/zsh.d/ ${HOME}/.zsh.d
mv ${HOME}/.ssh ${HOME}/.ssh_bak
unlink ${HOME}/.ssh
ln -Tsfv ${SCRIPTDIR}/ssh/ ${HOME}/.ssh

rm ${HOME}/.README
rm ${HOME}/.dotlinker.sh

echo ""
echo "Done."
