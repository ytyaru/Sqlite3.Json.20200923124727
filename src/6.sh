#!/usr/bin/env bash
sqlite3 :memory: 'select 1;'
sqlite3 :memory: 'select char(10) 1;'
sqlite3 :memory: 'select x'0a' 1;'
sqlite3 :memory: 'select \
 1;'
sqlite3 :memory: "select $'\n' 1;"
sqlite3 :memory: 'select '$'\n'' 1;'
