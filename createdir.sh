#!/bin/bash

echo "creating backup directory $1..."
mkdir -p $1
#mkdir -p : no error if existing, make parent directories as needed