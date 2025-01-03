alias mircatch='nc -l -p 1234 | gzip -dc | mplayer -demuxer rawvideo -rawvideo w=384:h=640:format=rgba -'
alias ncip='sudo snap run nextcloud.occ config:system:set trusted_domains 2 --value=192.168.1.7'
alias df='df -x squashfs'
alias mount='mount -t nosquashfs,nocgroups'
alias vf='vim $(find -type f 2>&1 | grep -v "Permission denied" | fzf)'
alias please="sudo \"$@\""
alias diff="diff -u --color"
alias colour="sed 's/ 500 /\x1b[41m 500 /;s/\s200\s/\x1b[42m 200 /;s/ 404 /\x1b[41m 404 /;s/$/\x1b[0m/'"
alias magentoinstall="sudo docker-compose exec magento /app/bin/magento setup:ins    tall --admin-firstname=Tobiyo --admin-lastname=Kuujikai --admin-email=g.akrum@sma    rtsecure.solutions --admin-user=admin --admin-password='user1i1' --base-url=https    ://magento2.shop --base-url-secure=https://magento2.shop --backend-frontname=admi    n --db-host=mysql --db-name=magento --db-user=root --db-password=root --use-rewri    tes=1 --language=en_US --currency=SRD --timezone=America/New_York --use-secure-ad    min=1 --admin-use-security-key=1 --session-save=files --use-sample-data"
alias qemustart="qemu-system-x86_64 -hda ubuntu-touch-mainline-generic-amd64.img -vga virtio -display gtk,gl=on -m 2G -enable-kvm"
alias myls="`echo history| grep ${1:-ls}|grep -v \"grep\|myls\"|tail -n 1|awk '{print $2}'`"
function srcrackle () { cd ${HOME}/.local/src/${1-crackle}; }
