#!/bin/bash

yarn publish dist --new-version echo `git describe --tags $(git rev-list --tags --max-count=1)` && sed -e "s/^v//" --no-git-tag-version
