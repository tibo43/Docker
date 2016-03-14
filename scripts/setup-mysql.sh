#!/bin/bash
PASS=azerty
mysql -uadmin -p$PASS -e "CREATE DATABASE javacard"
mysql -uadmin -p$PASS javacard < /app/sql/dump.sql
