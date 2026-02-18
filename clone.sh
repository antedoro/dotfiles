#!/bin/sh

echo "Cloning repositories..."

CODE=$HOME

# Sites
if [ ! -d "$CODE/rsync_scripts" ]; then
    git clone https://github.com/antedoro/rsync_scripts.git "$CODE/rsync_scripts"
else
    echo "rsync_scripts already exists, skipping..."
fi

