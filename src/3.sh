#!/usr/bin/env bash
set -Ceu
#---------------------------------------------------------------------------
# SQLite3でTSVからJSON文字列を作成する（3.33.0以降）。
# CreatedAt: 2020-09-23
#---------------------------------------------------------------------------
Run() {
	declare -A KV
	KV['name']='RepoName'
	KV['description']='リポジトリの説明文。'
	KV['homepage']='https://...'
	TABLE_NAME=Parameters
	cat <(IFS=$'\t'; echo "${!KV[*]}") <(IFS=$'\t'; echo "${KV[*]}") | 
	sqlite3 :memory: -batch -interactive \
	'.mode tabs' '.import /dev/stdin '"$TABLE_NAME" \
	'.mode json' 'select * from '"$TABLE_NAME" \
	| sed 's/^\[//' | sed 's/\]$//'
}
Run "$@"
