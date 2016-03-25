#!/bin/bash
PASS=$(cat /app/files/khdfgeaqejalh/bdd)
mysql -uadmin -p$PASS -e "CREATE DATABASE javacard"
mysql -uadmin -p$PASS javacard < /app/sql/dump.sql
