#!/usr/bin/env bash
set -Ceu
#---------------------------------------------------------------------------
# SQLite3でTSVからJSON文字列を作成する（3.33.0以降）。
# CreatedAt: 2020-09-23
#---------------------------------------------------------------------------
Run() {
	TABLE_NAME=Parameters
	SQL=$(cat <<-EOS
		create table ${TABLE_NAME}(
			Age  int,
			Name text
		);
		EOS
	)
	echo -e "12\tYamada" | 
	sqlite3 :memory: "$SQL" \
	'.mode tabs' '.import /dev/stdin '"$TABLE_NAME" \
	'.mode json' 'select * from '"$TABLE_NAME" \
	| sed 's/^\[//' | sed 's/\]$//'
}
Run "$@"
