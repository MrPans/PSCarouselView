#!/usr/bin/env bash

source ~/.rvm/scripts/rvm
rvm install 2.2.3
pod trunk push --only-errors --verbose