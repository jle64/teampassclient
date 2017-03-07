#!/usr/bin/env bash
# Imports Teampass content into the "pass" password manager
# Needs the teampassclient teampass command available and configured


[ -x "$(which teampass)" ] || echo 'Error: The teampass command is needed.'

IFS=$'\n'
for PW in $(teampass list); do
	# pass doesn't like stuff ending by '/'
	NEW_PW=$(echo "${PW}" | sed 's#/$##')
	teampass show "${PW}" | pass add -m teampass/"${NEW_PW}"
done