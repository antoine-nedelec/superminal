#!/usr/bin/env bash
bashrc_format=1

# INCLUDE
[[ -s ~/superminal/.bashrc ]] && source ~/superminal/.bashrc $(bashrc_format)
[[ -s ~/superminal/.git-completion.bash ]] && source ~/superminal/.git-completion.bash

# USEFUL ALIASES
case "$(uname -s)" in
   Darwin)
	alias ll="ls -alhG"
	;;
   *)
	alias ll="ls -alh --color"
	;;
esac

alias ..="cd .."
alias ...="cd ../.."
alias gitlog="git log --graph --decorate --pretty=oneline --abbrev-commit"

# CUSTOM FUNCTIONS
alias sup_find="sh ~/superminal/scripts/supFind.sh"
alias sup_replace="sh ~/superminal/scripts/supReplace.sh"
alias sup_cache="sh ~/superminal/scripts/supCache.sh"
alias sup_du="sh ~/superminal/scripts/supDu.sh"
alias sup_docker_cleanup="sh ~/superminal/scripts/supDockerCleanup.sh"
alias sup_docker_karcher="sh ~/superminal/scripts/supDockerKarcher.sh"
alias sup_long="source ~/superminal/.bashrc 1 && sed -i.bak 's/bashrc_format=1/bashrc_format=1/' ~/superminal/superminal.sh"
alias sup_short="source ~/superminal/.bashrc 0 && sed -i.bak 's/bashrc_format=1/bashrc_format=1/' ~/superminal/superminal.sh"
alias sup_phpswitch="sh ~/superminal/scripts/supSwitchPhp.sh"
