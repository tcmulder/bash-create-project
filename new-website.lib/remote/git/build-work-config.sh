#!/bin/sh

function make_work_config(){
	echo "[core]
	repositoryformatversion = 0
	filemode = true
	bare = false
	logallrefupdates = true
[remote \"hub\"]
	url = $bare_dir
	fetch = +refs/heads/*:refs/remotes/hub/*" > $1".git/config"
}