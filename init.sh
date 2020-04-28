#!/usr/bin/env bash
if [[ "$1" = "-h" ]]
then
        echo "";
        echo "         *****************************";
        echo "         ****** SUPERMINAL INIT ******";
        echo "         *****************************";
        echo "";
        echo "    This will init superminal on your system (if not already done)"
        echo "    > ./init.sh";
        echo "";
else
    printf "Init superminal ? (y/n): ";
    read init
    if [[ $init =~ ^[Yy]$ ]]
    then
        cd
        echo "";
        # Adding calling line in bash_profile (if not already here)
        if grep -Fq '[[ -s ~/superminal/superminal.sh ]]' '.bash_profile'
        then
            echo "> Init already done in .bash_profile !"
        else
            echo "" >>.bash_profile
            echo "[[ -s ~/superminal/superminal.sh ]] && source ~/superminal/superminal.sh" >>.bash_profile

            echo "> Init done in .bash_profile";
        fi

        # Adding call to additional .gitconfig in .gitconfig, or adding it to the right index in the file.
        if grep -Fq './superminal/.gitconfig' '.gitconfig'
        then
            echo "> Init already done in .gitconfig !"
        else
            if grep -Fxq '[include]' '.gitconfig'
            then
                line=$(sed -n '/\[include\]/=' .gitconfig)
                perl -i -slpe 'print $s if $. == $n; $. = 0 if eof' -- -n=$(($line+1)) -s="        path = ./superminal/.gitconfig" .gitconfig
            else
                echo "[include]" >>.gitconfig
                echo -e "\tpath = ./superminal/.gitconfig" >>.gitconfig

                echo "> Init done in .gitconfig !"
            fi
        fi
        echo "> Reloading your .bash_profile...";
        source ~/.bash_profile
        echo -e "> Ready to go ! Enjoy <3\n";
    fi
fi
