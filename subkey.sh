#!/bin/bash

if [ -f /usr/local/bin/subkey ]; then
    echo "Subkey is already installed"
else
    wget -O https://doubletop-bin.ams3.digitaloceanspaces.com/tools/subkey /usr/local/bin/subkey
    chmod +x /usr/local/bin/subkey
    echo "Subkey is installed"
fi

if [ -f $HOME/keys_$1.txt ]; then
    mv $HOME/keys_$1.txt $HOME/keys_$1.txt_$(date +%Y%m%d_%H%M%S)
fi

for i in {1..$1}; do
    subkey generate -n $2 -w 12 --output-type json | jq -r '.secretPhrase, .ss58PublicKey' | awk '{printf "%s;", $0}' | sed 's/;$/\n/' >> $HOME/keys_$1.txt
done

echo "For view keys use: cat $HOME/keys_$1.txt"
echo "Done"