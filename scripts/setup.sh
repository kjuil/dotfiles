#!/bin/bash

[ -d "$HOME/.config" ] && ln -s $HOME/.dotfiles/.config/* $HOME/.config || ln -s $HOME/.dotfiles/.config $HOME
[ -f "$HOME/.bashrc" ] || ln -s $HOME/.dotfiles/.bashrc $HOME/.bashrc
[ -f "$HOME/.bash_profile" ] || ln -s $HOME/.dotfiles/.bash_profile $HOME/.bash_profile
[ -f "$HOME/.inputrc" ] || ln -s $HOME/.dotfiles/.inputrc $HOME/.inputrc

source $HOME/.bashrc
