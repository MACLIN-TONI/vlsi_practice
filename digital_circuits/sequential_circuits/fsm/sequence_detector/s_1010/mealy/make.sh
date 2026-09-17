#!/bin/bash

dut=$1

mkdir -p $dut/{rtl,tb,docs,waves,sim}
cd $dut
touch rtl/$dut.v
touch tb/tb_$dut.v
touch Makefile
