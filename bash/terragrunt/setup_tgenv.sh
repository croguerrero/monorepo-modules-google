#!/bin/bash
git clone https://github.com/cunymatthieu/tgenv.git "${HOME}"/.tgenv
ln -s "${HOME}"/.tgenv/bin/* "${HOMEBIN}"
tgenv install
