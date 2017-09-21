
#VIMのインストール
sudo yum -y install vim

#httpdのインストール
sudo yum -y install httpd
#httpdのスタート（Apacheサーバ起動）
sudo systemctl start httpd
#Apacheサーバの自動起動
sudo systemctl enable httpd


#ファイヤーウォールの停止
sudo systemctl stop firewalld
#ファイヤーウォールをOS起動時に自動停止させる
sudo systemctl disable firewalld

#Webで表示するフォルダを削除
sudo rm -rf /var/www/html
#Webで表示するフォルダを．共有フォルダである/vagrantとシンボリックリンク
sudo ln -fs /vagrant /var/www/html


#index.htmlのファイルの作成
cd /vagrant
touch index.html
echo "<!DOCTYPE html><html><head><meta charset='utf-8'><title>test</title></head><body>Hello World</body></html>" > index.html


#Epelリポジトリの追加
sudo yum -y install epel-release
#Remiリポジトリの追加
wget http://rpms.famillecollet.com/enterprise/remi-release-7.rpm
sudo rpm -ivh ./remi-release-7.rpm


#phpのインストール
sudo yum -y --enablerepo=remi-php70,remi install php php-mcrypt php-mbstring php-fpm php-gd php-xml php-pdo php-mysqlnd php-devel


#MariaDBの削除(MySQLと競合を起こすため)
sudo yum -y remove mariadb-libs


#MySQLのインストール(http://dev.mysql.com/downloads/repo/yum/)
sudo yum -y install http://dev.mysql.com/get/mysql57-community-release-el6-7.noarch.rpm
sudo yum -y install mysql-community-server


#Composerのインストール
curl -sS https://getcomposer.org/installer | php
sudo mv composer.phar /usr/local/bin/composer


#gitのインストール
sudo yum -y install git
