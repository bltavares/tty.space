#!/bin/bash

if ! which kickstart > /dev/null; then
  echo kickstart not found on the PATH.
  echo Check it on https://github.com/bltavares/kickstart
  exit 1
fi

[ -z "$LETSENCRYPT_EMAIL" ] && echo "LETSENCRYPT_EMAIL must be set to deploy" && exit 1

kickstart deploy root@tty.space users security mail motd cron talk nntp applications ssl web sshd bouncer <<<"$LETSENCRYPT_EMAIL"
