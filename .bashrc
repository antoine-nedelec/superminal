# _________________________________________________________________________________________
# FUNCTIONS FOR PROMPT
GIT_BRANCH() {
    local TEMP=$(git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/');
    [[ ! -z $TEMP ]] && echo "${TEMP}"
}
PWD() {
    echo "$*" |perl -pne \
    's:^'"$HOME"':~:;'"$cygpwd"'s:^(.{10}).{4}.*(.{20})$:$1...$2:;'
}
PWD_LONG() {
    echo "$*" |perl -pne \
    's:^'"$HOME"':~:;'"$cygpwd"
}

# _________________________________________________________________________________________
# PROMPT COLOR INFO
# BACKGROUND                            COLOR (LEFT VALUE)              TYPE (RIGHT VALUE)
# Black background: 40                  Black: 30                       Normal Text: 0
# Blue background: 44                   Blue: 34                        Bold or Light Text: 1 (It depends on the terminal emulator.)
# Cyan background: 46                   Cyan: 36                        Dim Text: 2
# Green background: 42                  Green: 32                       Underlined Text: 4
# Purple background: 45                 Purple: 35                      Blinking Text: 5 (This does not work in most terminal emulators.)
# Red background: 41                    Red: 31                         Reversed Text: 7 (This inverts the foreground and background colors, so you’ll see black text on a white background if the current text is white text on a black background.)
# White background: 47                  White: 37                       Hidden Text: 8
# Yellow background: 43                 Yellow: 33
# _________________________________________________________________________________________
# BG SYNTAX:            \[\033[VALUEm\]
# COLOR SYNTAX:         \[\033[LEFT_VALUE;RIGHT_VALUEm\] or \[\033[LEFT_VALUEm\]
# _________________________________________________________________________________________

if [[ "$(id -u)" = 0 ]]
then
    # root: red BG
    COLOR_PREFIX="\[\033[41;37m\]"
elif [[ "$(id -un)" != "$(basename $HOME)" ]]
then
    # not root, not self: red text
    COLOR_PREFIX="\[\033[31;m\]"
else
    # user color
    COLOR_PREFIX="\[\033[;37m\]"
fi

COLOR_PATH="\[\033[40;32m\]"
COLOR_GIT="\[\033[40;31;1m\]"
COLOR_TEXT="\[\033[40;37;0m\]"

# PROMPT TEXT
PR_USER="\u"
PR_HOST="\h"
PR_PREFIX=" [${PR_USER}:${PR_HOST}]"

if [[ "$1" = "0" ]]
then
    PR_PATH=" ╚ \$(PWD \w) ╗"
    PR_GIT=" \$(GIT_BRANCH)"
else
    PR_PATH=" ╚ \$(PWD_LONG \w) ╗"
    PR_GIT=" \$(GIT_BRANCH)\n"
fi

PR_END=" ■ "

PS1="\n${COLOR_PREFIX}${PR_PREFIX}${COLOR_PATH}${PR_PATH}${COLOR_GIT}${PR_GIT}${COLOR_TEXT}${PR_END}"
unset USER_COLOR TEXT_COLOR PATH_COLOR BASIC_COLOR BASIC_COLOR GIT_COLOR PR_USER PR_HOST PR_DIR_PATH PR_BRANCH PR_END

export LSCOLORS=bxgxcxdxxxegedabagacad
export LS_COLORS=di=31:ln=36:so=32:pi=33:ex=0:bd=46:cd=43:su=41:sg=46:tw=42:ow=43
