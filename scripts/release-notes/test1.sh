#!/bin/sh
set -eux

. common.sh

t=test1
relnotescript=${1:?}
rewrite=${2:-}

test_init

(
    cd $t
    init_repo
    git branch feature
    make_change "master update"
    git checkout feature
    make_change "feature A

Release note (bug fix): feature A
"
    tag_pr 1
    git checkout master
    merge_pr feature 1 "PR title"
)

test_end
