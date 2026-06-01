#!/bin/bash

dut=$1

mkdir -p $dut/{rtl,tb,sim,docs,waves}
cd $dut
touch rtl/$dut.v
touch tb/tb_$dut.v
touch docs/spec.txt docs/notes.txt

touch Makefile

