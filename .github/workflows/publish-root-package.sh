#!/bin/bash

yarn publish dist --no-git-tag-version --new-version echo `git describe --tags $(git rev-list --tags --max-count=1)` | sed -e "s/^v//"
