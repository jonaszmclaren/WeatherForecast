#!/bin/bash

xcodegen generate --use-cache
xcodebuild -resolvePackageDependencies
