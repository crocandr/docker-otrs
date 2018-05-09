#!/bin/bash

OTRS_CONFIG="/opt/otrs/Kernel/Config.pm"

if [ ! -z $OTRS_DB_HOST ]
then
  echo "OTRS DB HOST: $OTRS_DB_HOST"
  sed -i "s@Self->{DatabaseHost}.*=.*'.*;@Self->{DatabaseHost} = \'$OTRS_DB_HOST\';@g" $OTRS_CONFIG
fi

if [ ! -z $OTRS_DB ]
then
  echo "OTRS DB: $OTRS_DB"
  sed -i "s@Self->{Database}.*=.*'.*;@Self->{Database} = \'$OTRS_DB\';@g" $OTRS_CONFIG
fi

if [ ! -z $OTRS_DB_USER ]
then
  echo "OTRS DB USER: $OTRS_DB_USER"
  sed -i "s@Self->{DatabaseUser}.*=.*'.*;@Self->{DatabaseUser} = \'$OTRS_DB_USER\';@g" $OTRS_CONFIG
fi

if [ ! -z $OTRS_DB_PASSWORD ]
then
  echo "OTRS DB PASSWORD: $OTRS_DB_PASSWORD"
  sed -i "s@Self->{DatabasePw}.*=.*'.*;@Self->{DatabasePw} = \'$OTRS_DB_PASSWORD\';@g" $OTRS_CONFIG
fi

chmod 777 $OTRS_CONFIG

su - otrs -c "/opt/otrs/bin/otrs.Daemon.pl start"
su - otrs -c "/opt/otrs/bin/Cron.sh start"
apache2ctl -DFOREGROUND
