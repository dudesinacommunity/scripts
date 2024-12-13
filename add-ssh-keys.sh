#!/bin/bash

dudelab_user=$1
user=${2:-$(id -un)}

home=$(eval echo "~$user")
date=$(date +"%Y-%m-%d %H:%M:%S")

keys=$(curl https://dudelab.dev/$dudelab_user.keys)

echo "# dudelab.dev/$dudelab_user.keys ($date)" >> $home/.ssh/authorized_keys
echo "$keys" >> $home/.ssh/authorized_keys