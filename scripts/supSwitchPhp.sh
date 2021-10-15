#!/bin/bash
# Function to check if the PHP version is valid
PHPVERSION=$(php -r "echo PHP_VERSION;");

if [ "$PHPVERSION" = "5.6.40" ]; then
	echo "Switching from PHP 5.6 to 7.4 !";
	brew unlink php@5.6 && brew link php@7.4 --force --overwrite;
	sudo cp /etc/apache2/httpd.conf.php7 /etc/apache2/httpd.conf;
else
	echo "Switching from PHP 7.4 to 5.6 !";
	brew unlink php@7.4 && brew link php@5.6 --force --overwrite;
	sudo cp /etc/apache2/httpd.conf.php5 /etc/apache2/httpd.conf;
fi

dscacheutil -flushcache;
sudo apachectl restart;

