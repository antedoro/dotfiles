#!/bin/bash
# Una cosa terribile, lo so, ma quando avrò tempo...

DIR="$HOME/dotfiles"
HOST="notebook-xps-13"

cp -r $HOME/.config/sway/ $DIR/$HOST/home/.config/ 
cp -r $HOME/script $DIR/$HOST/home/
cp -r $HOME/pics $DIR/$HOST/home/
cp -r $HOME/.themes/Dracula-rp/ $DIR/$HOST/home/.themes/
cp $HOME/.Xdefaults $DIR/$HOST/home/
cp /etc/environment $DIR/$HOST/etc/  
echo "Fatto."

cp -i ~/dotfiles/.zshrc ~/
cp -i /Users/antedoro/dotfiles/.zshrc ~/
cp -i ~/dotfiles/.p10h.zsh ~/
cp .zshrc .p10k.zsh ~/
cp /Users/antedoro/dotfiles/.zshrc /Users/antedoro/dotfiles/.p10k.zsh /Users/antedoro/

