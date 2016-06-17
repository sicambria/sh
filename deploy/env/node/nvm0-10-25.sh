#!/bin/bash
sudo echo "Install Node v0.10.25 and NPM 1.3.x"
echo
curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.31.1/install.sh | bash
source ~/.profile
echo "-----------------------------------"

echo "DONE! Exit this Terminal window and continue in a new one!"

echo "Run these commands manually:"
echo "nvm install 0.10.25"
echo "nvm use 0.10.25"
echo "nvm alias default 0.10.25"
