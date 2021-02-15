#!/usr/bin/env bash

if [[ $(uname -m) != "aarch64" ]]; then
    echo -e "Your environment should be \e[32mAndroid (aarch64/arm64)\e[0m"
    exit 1
fi

#remove motd file
rm $PREFIX/etc/motd

# install coreutils
apt upgrade && apt update -y

# install packages
pkgs=("git" "wget" "zsh" "composer" "php" "apache" "php-apache" "mariadb" "rust" "clang" "camake")
pkgsLength=${#pkgs[@]}
for (( i = 0; i <= $pkgsLength; i++ )); do
    pkg install ${pkgs[$i]} -y
done

pkg upgrade

# download server configuration file via wget
wget https://raw.githubusercontent.com/amm834/developement_env_setup/main/httpd.conf


# remove default configuration file
rm $PREFIX/etc/apache2/httpd.conf

# move downloaded configuration file
mv httpd.conf $PREFIX/etc/apache2

# download service file
wget https://raw.githubusercontent.com/amm834/developement_env_setup/main/service

# change as executable file
chmod +x service

# move service file to bin
mv service $PREFIX/bin/

# install oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
