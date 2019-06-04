#!/bin/sh

echo "[ Creating self installing executable .... ]"

rm -rf  ~/.vim/tmp/*
cd ~/
DATA="$(cd ~/; find  .vim* .bash*  .global* .input*  bin* .custom* -type f |xargs tar --exclude=.bash_history --exclude=.vimyankring_history_v2.txt --exclude=*.o --exclude=*.exe --exclude=*.gz --exclude=*.tare --exclude=*.gz --exclude=*.tare --exclude=*.gz --exclude=*.tar  --exclude=*.a  --exclude=*.so --exclude=binary -zcvf - |uuencode -)"
#DATA="$(find . -name "*.cpp" |xargs tar -zcvf - |uuencode -)"
#echo "[  $DATA   ]"


#Headers
cat <<EOF >~/installer
#!/bin/sh

echo "[ Taking backup of existing files and settings ]"
filename="config_old_\$(date +%m.%d.%y-%H:%M:%S).tar.gz"
mkdir -p ~/.backup
find ~/.vim* ~/.bash* ~/.net.* ~/.screen.* ~/.input.* ~/.global.* | xargs tar -zcvf ~/.backup/\$filename
EOF

#Content
cat <<EOF >>~/installer
echo "[ Installing the binaries ]"
cat<<'BIN_DATA' | uudecode |tar -zxvf - -C tmp
$DATA
BIN_DATA
EOF

#Footer
cat <<EOF >>~/installer
#!/bin/sh
echo "[ Installation complete ]"
EOF

chmod 777 ~/installer
