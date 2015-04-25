#!/bin/bash

if ! which kickstart > /dev/null; then
  echo kickstart not found on the PATH.
  echo Check it on https://github.com/bltavares/kickstart
  exit 1
fi

kickstart deploy root@tty.space users web
