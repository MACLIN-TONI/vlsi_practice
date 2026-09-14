#!/bin/bash

dut=$1

mkdir -p $dut/{rtl,tb,docs,waves,sim}
cd $dut
touch docs/README.txt docs/nots.txt
touch rtl/$dut.v
touch tb/tb_$dut.v
touch Makefile
