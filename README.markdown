`pandoc-completion.bash` is a bash autocompletion script for pandoc. It supports autocompletion of options, as well as autocompletion of
file paths in the pandoc data directory and $HOME/.csl, where 
appropriate.

To use, put it somewhere, e.g., `$HOME/etc/bash-completions.d/pandoc-completion.bash`, and put something like

~~~
[[ -s "$HOME/etc/bash-completions.d/pandoc-completion.bash" ]] && source "$HOME/etc/bash-completions.d/pandoc-completion.bash"
~~~

into your `.bashrc`.

This script is messy. I don't know a lot about writing bash completion scripts,
and I find that the documentation is rather thin. But it works for me.

`pandoc.usage` is a usage file for use with [Compleat](https://github.com/mbrubeck/compleat), a haskell program that generates bash and zsh completions based upon an abstract specification of a command's command line option. This is a more elegant solution, but I can't get it to provide completions for files not in the current path, so at the moment it will not look for bibliography files and reference.odt files in pandoc's data folder.
