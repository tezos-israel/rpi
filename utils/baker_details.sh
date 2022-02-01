#!/bin/bash


echo "What's is the user name that runs tezos (default: $USER)"
read -r user
user=${user:-$USER}

echo "What's is your baker alias (default: baker)"
read -r baker
baker=${baker:-"baker"}