#!/bin/bash

dut=$1

mkdir -p $dut/{rtl,tb,sim,docs,waves}
cd $dut

touch Makefile

