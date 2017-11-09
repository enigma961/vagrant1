
# install vim 
sudo yum -y install vim

# install apache
sudo yum -y install httpd
# start apache
sudo systemctl start httpd
# add apache to the not  auto start
sudo systemctl enable httpd

# stop firewall
sudo systemctl stop firewalld
# add firewall to the not  auto start
sudo systemctl disable firewalld

# set vagrant share folder
sudo rm -rf /var/www/html
sudo ln -fs /vagrant /var/www/html


# add index.htm
cd /vagrant
touch index.html
echo "<!DOCTYPE html><html><head><meta charset='utf-8'><title>test</title></head><body>Hello World</body></html>" > index.html


# install Epel
sudo yum -y install epel-release
# install Remi
wget http://rpms.famillecollet.com/enterprise/remi-release-7.rpm
sudo rpm -ivh ./remi-release-7.rpm

# install php
sudo yum -y --enablerepo=remi-php70,remi install php php-mcrypt php-mbstring php-fpm php-gd php-xml php-pdo php-mysqlnd php-devel

# remove MariaDB
sudo yum -y remove mariadb-libs

# MySQL
    #MySQLのインストール(http://dev.mysql.com/downloads/repo/yum/)
    #sudo yum -y install http://dev.mysql.com/get/mysql57-community-release-el6-7.noarch.rpm
    #sudo yum -y install mysql-community-server


# add the mysql yum repo
yum -y localinstall http://dev.mysql.com/get/mysql57-community-release-el7-7.noarch.rpm
# install mysql server
yum -y install mysql-community-server
# start the mysql service
systemctl start mysqld
# add mysql to the auto start
systemctl enable mysqld

PASSWORD=$(grep 'temporary password' /var/log/mysqld.log | sed 's/.* //g')

echo "Root password: ${PASSWORD}"

# Update password so it's not expired; remove password validator plugin, remove password
mysql -p"${PASSWORD}" --connect-expired-password -e \
 "ALTER USER USER() IDENTIFIED BY '@JCQZQBgZwY4S0e*KbxU'; UNINSTALL PLUGIN validate_password; ALTER USER USER() IDENTIFIED BY '';" || \
 echo "NOTICE: unable to update password, maybe this has been done before"
systemctl restart mysqld

echo "MySQL installed"


#Composer install
curl -sS https://getcomposer.org/installer | php
sudo mv composer.phar /usr/local/bin/composer


#git install
sudo yum -y install git

