# vim: set filetype=bash
alias vi=vim
alias h="history | grep "
alias f="find . | grep "
alias p="ps aux | grep "
alias a="alias  | grep "
alias g="grep -rnw . -e " # Go find me some text [info](https://explainshell.com/explain?cmd=grep+-rnw+.+-e+text)
alias c="clear"
alias {:q,:Q,:qa}="exit"
alias bs="bundle show |grep "
alias fing="sudo"
alias Kill="sudo kill -s SIGTERM "

# Quick edit
alias oh='   sudo vim ~/hosts.base && build_hosts'
alias ohp='  sudo vim ~/hosts.personal && build_hosts'
alias bh='   build_hosts'
alias ossh=' sudo vim ~/.ssh/config'
alias ovim=" vim ~/.vimrc"
alias ozsh=" vim ~/.zshrc"
alias obash="vim ~/.bash_profile"
alias oalias="vim ~/dot_files/include/base_aliases.zsh"
alias ofunc="vim ~/dot_files/include/functions.zsh"
alias ogit=" vim ~/dot_files/include/git_aliases.zsh"
alias sbash="source ~/.bash_profile; clear"
alias zbash="source ~/.zshrc; clear"
alias bog="  bundle open"
alias psd="open -a /Applications/Adobe\ Photoshop\ 2020/Adobe\ Photoshop\ 2020.app"
alias opry=" vim ~/.pryrc"
alias myvhost="vim /usr/local/etc/httpd/extra/httpd-vhosts.conf"
alias oprompt="vim ~/dot_files/shadoath.zsh-theme"
# Server quick edit
alias vhost="sudo vim /etc/httpd/conf.d/http-vhosts.conf"
alias ctags="`brew --prefix`/bin/ctags"


# Special commands
## delete all files starting with ._
alias no_ds="find . -type f -name '._*' -exec rm {} +"

# Laravel
alias phps="php artisan serve"

# Servers
alias sql=" mysql.server start"
alias ssnr="sudo service nginx restart"
alias ssmr="sudo service mysql restart"
alias ssrn="sudo systemctl restart nginx"
alias sshr="sudo service httpd restart"
alias ssar="sudo service apache2 restart"

# Quick ssh commands
alias ssfs="ssh skyfox@sfs"              # SkyFoxStudios

# Prenda
alias shub="ssh -N ubuntu@prenda-hub"
alias pw="cd /code/prenda-verse/prendaworld"
alias m="meteor-dev"
alias mt="meteor-test"
alias mp="meteor-prod"
alias meteor-dev="METEOR_OFFLINE_CATALOG=1 meteor run --settings credentials.json  --no-release-check  --exclude-archs web.browser.legacy"
alias meteor-test="METEOR_OFFLINE_CATALOG=1 MONGO_URL=mongodb://127.0.0.1:27017/meteor-test meteor --settings dev-settings.json  --no-release-check --exclude-archs web.browser.legacy"
alias meteor-prod="MONGO_URL=mongodb://localhost:27017/prendacoins meteor  --settings settings.json --no-release-check --exclude-archs web.browser.legacy"
alias mni="meteor npm ci"

# Time
alias retime="sudo ntpdate time.nist.gov"
alias msttime="sudo rm /etc/localtime; sudo ln -s /usr/share/zoneinfo/America/Denver /etc/localtime"
alias fixtime="sudo timedatectl set-timezone America/Denver"

# Mac OS 10.12.6
alias clear_dns="sudo dscacheutil -flushcache;sudo killall -HUP mDNSResponder;"

# Quick jumps
alias cdd="   cd ~/dot_files"

# ls aliases
alias ll="ls -lh"
alias la="ls -lah"
alias ls="ls -la"
