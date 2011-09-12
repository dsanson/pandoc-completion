This is a bash autocompletion script for pandoc.

It supports autocompletion of options, as well as autocompletion of
file paths in the pandoc data directory and $HOME/.csl, where 
appropriate.

To use, put it somewhere, e.g., `$HOME/etc/bash-completions.d/pandoc-completion.bash`, and put something like

~~~
[[ -s "$HOME/etc/bash-completions.d/pandoc-completion.bash" ]] && source "$HOME/etc/bash-completions.d/pandoc-completion.bash"
~~~

into your `.bashrc`.

This script is messy. I don't know a lot about writing bash completion scripts,
and I find that the documentation is rather thin. But it works for me.

Improvements welcome.
