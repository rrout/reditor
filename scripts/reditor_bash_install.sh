#!/bin/sh
set -e

cd ~/reditor/bash
touch ~/.bashrc

echo '

source ~/reditor/bash/.bashrc

' >> ~/.bashrc

echo "Installed the reditor bash configuration successfully! Enjoy :-)"

