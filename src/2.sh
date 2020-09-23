#!/usr/bin/env bash
set -Ceu
#---------------------------------------------------------------------------
# SQLite3でTSVからJSON文字列を作成する（3.33.0以降）。
# CreatedAt: 2020-09-23
#---------------------------------------------------------------------------
Run() {
	NAME='RepoName'
	DESCRIPTION='リポジトリの説明文。'
	HOMEPAGE='https://...'
	KEYS=(name description homepage)
	VALUES=("$NAME" "$DESCRIPTION" "$HOMEPAGE")
	TABLE_NAME=Parameters
	cat <(IFS=$'\t'; echo "${KEYS[*]}") <(IFS=$'\t'; echo "${VALUES[*]}") | 
	sqlite3 :memory: -batch -interactive \
	'.mode tabs' '.import /dev/stdin '"$TABLE_NAME" \
	'.mode json' 'select * from '"$TABLE_NAME" \
	| sed 's/^\[//' | sed 's/\]$//'
}
Run "$@"
