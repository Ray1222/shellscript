#!/bin/sh

sq=`diff -q 1234 12345 | awk '{print $5}'`

echo $sq
