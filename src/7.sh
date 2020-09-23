#!/usr/bin/env bash
SQL='create table Parameters(Age INT,Name TEXT)'
echo -e "$SQL" | sed 's/ INT,/ INT,\'$'\n/g'
