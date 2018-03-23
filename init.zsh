#!/usr/bin/env zsh

# ZsHero - A ZSH bootstrap for all your dotfiles need

# A variable as a starting point of ZsHero
#
# For future reference:
# ${(%):-%N} - Get's the current script being executed/sourced
# :A - Expand path to show the full location (ex: ~/.zshero/init.zsh)
# :h - Removes the script name, leaving only the folder (ex: ~/.zshero)
typeset -gx ZSHERO_ROOT="${${(%):-%N}:A:h}"

# Load our 'base' function, which is basically a loader for all the other functions
source "$ZSHERO_ROOT/base/init.zsh"

# Setup autoload
source "$ZSHERO_ROOT/autoload/init.zsh"

__zshero::base "const/const"
__zshero::base "io/print"
__zshero::base "core/*"
__zshero::base "config/*"


__zshero::core::core::variables
