#!/usr/bin/env bash


openssl genrsa -out dave.key 4096

openssl req -config ./csr.cnf -new -key dave.key -nodes -out dave.csr
