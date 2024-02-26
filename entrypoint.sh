#!/bin/bash

set -e

PACKAGE_TO_BUILD="$1"

pwd

ls -la /root

# Make sure the package to build is provided.
if [ -z "$PACKAGE_TO_BUILD" ]; then
  echo "No package to build"
  exit 1
fi

# Make sure PACKAGE_TO_BUILD has '.spec' extension.
if [[ $PACKAGE_TO_BUILD != *.spec ]]; then
  PACKAGE_TO_BUILD="$PACKAGE_TO_BUILD.spec"
fi

# Make sure the spec file exists.
if [ ! -f $PACKAGE_TO_BUILD ]; then
  echo "Spec file not found: $PACKAGE_TO_BUILD"
  exit 1
fi

echo "Setting up RPM build tree"
rpmdev-setuptree

# Convert the spec file to Unix format.
dos2unix $PACKAGE_TO_BUILD

# Download the source files.
spectool -g -R $PACKAGE_TO_BUILD

# Get package dependencies.
dnf builddep -y $PACKAGE_TO_BUILD

# Build the package.
rpmbuild -ba $PACKAGE_TO_BUILD