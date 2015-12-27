#!/bin/bash

DATADIR='/var/lib/mysql'
MYSQL_DEBIAN_PASSWORD=$(grep password /etc/mysql/debian.cnf | head -1 |
awk -F= '{ print $2 }' | sed -e 's/ //')

if [ ! -d "$DATADIR/mysql" ]; then
	mysql_install_db
	mysqld_safe &
	sleep 5
	tempSqlFile='/mysql-first-time.sql'
	cat > "$tempSqlFile" <<-EOSQL
		UPDATE mysql.user SET Password=PASSWORD('${MYSQL_ROOT_PASSWORD}') WHERE User='root';
		DELETE FROM mysql.user WHERE User='';
		DELETE FROM mysql.user WHERE User='root' AND Host NOT IN ('localhost', '127.0.0.1', '::1');
		DROP DATABASE IF EXISTS test;
		DELETE FROM mysql.db WHERE Db='test' OR Db='test\\_%';
		GRANT ALL ON *.* TO 'root'@'172.17.%' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}' WITH GRANT OPTION;
		GRANT ALL ON *.* TO 'root'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}' WITH GRANT OPTION;
		FLUSH PRIVILEGES;
		CREATE USER 'debian-sys-maint'@'localhost' IDENTIFIED BY '${MYSQL_DEBIAN_PASSWORD}';
		GRANT ALL PRIVILEGES ON *.* TO 'debian-sys-maint'@'localhost' IDENTIFIED BY '${MYSQL_DEBIAN_PASSWORD}';
		FLUSH PRIVILEGES;
	EOSQL
	mysql -uroot  < $tempSqlFile
	chown -R mysql:mysql $DATADIR
	mysqladmin -uroot -p${MYSQL_ROOT_PASSWORD} shutdown
fi

/usr/bin/mysqld_safe
