This repository contains two files, either of which can be used to for
bash command-line completion for pandoc. For now, I recommend using
`pandoc-completion.bash`. Ultimately, I'd like to replace
`pandoc-completion.bash` with `pandoc.usage`, but there are bugs that
need to ironed out before it can be recommended.

## pandoc-completion.bash

`pandoc-completion.bash` is a bash completion script for pandoc. It
supports completion of pandoc's command-line options, as well as
completion of file paths in the pandoc data directory and $HOME/.csl,
where appropriate. It provides the same completions, where appropriate,
for markdown2pdf.

Note that the script completes long options that take arguments as
`--opt arg` rather than `--opt=arg` (although the documentation doesn't
don't make this clear, pandoc supports both styles). But if you happen
to type something like

    pandoc --opt=<tab>

it should still work as expected.

So, for example,

    pandoc --template syllab<tab>

will complete filenames starting with `syllab` in the current directory
as well as in `~/.pandoc/templates`. (Note that the completion script
does not attempt to restrict the completion to templates that match your
output format---that is up to you.) Similarly,

    pandoc --csl chic<tab>

will complete filenames starting with `chic` and ending with `.csl` in
the current directory as well as in `~/.csl`. And

    markdown2pdf --bibliography potat<tab>

will complete filenames starting with `potat` with supported
bibliography extensions (`.bib`, `.mods`, etc.) in the current directory
as well as in `~/.pandoc`. And

    pandoc --reference-odt 

will do the same, for files ending in `.odt`.

To use, put it somewhere, e.g.,

    $HOME/etc/bash-completions.d/pandoc-completion.bash

and put something like

    [[ -s "$HOME/etc/bash-completions.d/pandoc-completion.bash" ]] && source "$HOME/etc/bash-completions.d/pandoc-completion.bash"

into your `.bashrc`.

Note that this script is messy. I don't know a lot about writing bash
completion scripts, and I find that the documentation of the options
governing `complete` and `compgen` is rather thin. But it works well
enough to be useful for me.

## pandoc.usage

`pandoc.usage` is a usage file for use with [Compleat][], a haskell
program that generates bash and zsh completions based upon an abstract
specification of a command's command line option. This is ultimately a
more elegant solution and easier to maintain, but

1.  I can't get it to provide completions for full paths to files not in
    the current path, so at the moment it will not look for bibliography
    files and reference.odt files in pandoc's data folder. (But it does
    support completions of templates in `~/.pandoc/templates` and csl
    files in `~/.csl`, since pandoc knows to search in these paths.)
2.  For some reason, it is not restricting completions when appropriate,
    so that

<!-- -->

    pandoc --template <tab>

completes both appropriate filenames *and* pandoc command-line options.

  [Compleat]: https://github.com/mbrubeck/compleat
