#!/usr/bin/env bash
sqlite3 :memory: -batch -interactive '.mode json' 'select 12 as Age, "Yamada" as Name'
