# superminal
Terminal customization

Clone all the content in your root folder, then add the following line in your `.bash_profile` file:

```
[[ -s ~/superminal/.bash_init_superminal ]] && source ~/superminal/.bash_init_superminal
```

Create or add to `~/.gitconfig` file:

```
[include]
    path = ./superminal/.gitconfig 
```

# Beneficials
- Nice and pretty prompt (also show the current GIT branch of the current folder at the end of your prompt)
- GIT completions (with tab) + git shortcuts (such as `git st`, `git co`, `gitlog`, ...)
- Cool aliases (`ll`, `...`)
- Cool scripts (try `myfind -h`, `myreplace -h`, `mycache -h`)
