#!/bin/bash

# This script was developed by Pascal to deploy
# from the staging environment to the productive website.

timestamp=$(date +"%Y%m%d%H%M")
ssh root@acwww0.mpi-sws.org "rsync -avz --exclude wp-config.php /var/www/wordpress/{stage,prod}/" || exit 2
ssh root@acwww0.mpi-sws.org "tar cvf wordpress${timestamp}.tar.xz /var/www/wordpress/" || exit 3
scp -3 root@acwww0.mpi-sws.org:"wordpress${timestamp}.tar.xz" root@acwww1.mpi-sws.org: || exit 4
ssh root@acwww0.mpi-sws.org "shred wordpress${timestamp}.tar.xz && rm wordpress${timestamp}.tar.xz" || exit 5
ssh root@acwww1.mpi-sws.org "tar xvf wordpress${timestamp}.tar.xz -C / && ( shred wordpress${timestamp}.tar.xz && rm wordpress${timestamp}.tar.xz)" || exit 6

stagepw=$(ssh root@acwww0.mpi-sws.org "grep DB_PASSWORD /var/www/wordpress/stage/wp-config.php | sed \"s/^.*', '\(.*\)');.*$/\1/\"")
prodpw=$(ssh root@acwww0.mpi-sws.org "grep DB_PASSWORD /var/www/wordpress/prod/wp-config.php | sed \"s/^.*', '\(.*\)');.*$/\1/\"")

ssh root@acwww0.mpi-sws.org "mysqldump -h acmysql0.mpi-sws.org -u wordpress_stage wordpress_stage -p${stagepw} | sed 's/www-stage.aircloak.com/aircloak.com/g' | mysql -h acmysql0.mpi-sws.org -u wordpress_prod wordpress_prod -p${prodpw}"
