#!/usr/bin/env bash
set -Ceu
#---------------------------------------------------------------------------
# SQLite3でTSVからJSON文字列を作成する（3.33.0以降）。
# CreatedAt: 2020-09-23
#---------------------------------------------------------------------------
Run() {
	TABLE_NAME=Parameters
	unset KV
	declare -A KV
	KV['Age']=12
	KV['Name']='Yamada'
	IsInt() { test 0 -eq $1 > /dev/null 2>&1 || expr $1 + 0 > /dev/null 2>&1; }
	IsFloat() { [[ "$1" =~ ^[0-9]+\.[0-9]+$ ]] && return 0 || return 1; }
	FIELDS=()
	for KEY in ${!KV[*]}; do
		TYPE='TEXT'
		IsFloat "${KV["$KEY"]}" && TYPE='REAL'
		IsInt "${KV["$KEY"]}" && TYPE='INT'
		FIELDS+=("    ${KEY} ${TYPE}")
	done
	SQL='create table '"$TABLE_NAME"'('$'\n'
	SQL+="$(echo -e "$(IFS=,; echo "${FIELDS[*]}")" | sed -r 's/ (INT|REAL|TEXT|NULL|BLOB|NUMERIC|INTEGER|DOUBLE|FLOAT|BOOLEAN|DATE|DATETIME),/ \1,\'$'\n/gi')"
	SQL+=$'\n'')'
	echo -e "12\tYamada" | 
	sqlite3 :memory: "$SQL" \
	'.mode tabs' '.import /dev/stdin '"$TABLE_NAME" \
	'.mode json' 'select * from '"$TABLE_NAME" \
	| sed 's/^\[//' | sed 's/\]$//'
}
Run "$@"
