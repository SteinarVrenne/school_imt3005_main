#!/bin/bash

if $2 = pentest
    ./pentest.sh

if $2 = forensics
    ./forensics.sh

if $2 = stego
    ./stego.sh


else if
    echo "Wrong parameter!"
