pandoc-completion.bash
----------------------

`pandoc-completion.bash` is a [bash completion script][] for [pandoc][].
It supports completion of `pandoc`'s command-line options, as well as
completion of filenames in the pandoc data directory, `~/.pandoc`, and
the csl styles directory, `~/.csl`, where appropriate. It provides the
same completions, where appropriate, for `markdown2pdf`.

`pandoc` is, in the words of its developer, John MacFarlane, a "swiss
army knife" for markup conversion. But when you use it with
`pandoc-completion.bash`, I think you'll find it feels a bit more like a
switchblade.

installation
------------

First get `pandoc-completion.bash`,

    git clone git@github.com:dsanson/pandoc-completion.git

or (if you don't want to be bothered with git)

    curl -O https://raw.github.com/dsanson/pandoc-completion/master/pandoc-completion.bash

Then put something like

    [[ -s "/path/to/pandoc-completion.bash" ]] && source "/path/to/pandoc-completion.bash"

in your `.bashrc`.

some further details about the implementation
---------------------------------------------

The script completes long options that take arguments as

    --opt arg

rather than

    --opt=arg

(although the documentation doesn't don't make this clear, `pandoc`
supports both styles). But if you happen to type something like

    pandoc --opt=<tab>

it should still work as expected.

Some options take filenames as arguments, and the script tries to be
smart about where it looks for possible filename completions:

-   `--template`: the current directory or `~/.pandoc/templates`,
    -   `markdown2pdf`: *completions are restricted to filenames that
        contain 'latex'*. This should cover both the current standard
        `name.format` scheme (e.g., `handout.latex`) and the old
        standard `format.name` scheme (e.g., `latex.handout`).
    -   `pandoc`: completions are not restricted by output format.

-   `--csl`: filenames ending in `.csl`, in the current directory or
    `~/.csl`.
-   `--citation-abbreviations`: filenames ending in `.json`, in the
    current directory or `~/.csl`.
-   `--biliography`: filenames ending in supported bibliography
    extensions (`.bib`, `.mods`, etc.), in the current directory or in
    `~/.pandoc`.
-   `--reference-odt`: filenames ending in `.odt` in the current
    directory or `~/.pandoc`.

pandoc.usage
------------

This repository used to include both `pandoc-completion.bash` and
`pandoc.usage`. `pandoc.usage` was a usage file for use with
[Compleat][], a haskell program that generates bash and zsh completions
based upon an abstract specification of a command's command line option.
I hoped it would ultimately provide a more elegant solution and be
easier to maintain, but

1.  I couldn't get it to provide completions for full paths to files not
    in the current path;
2.  I couldn't get it to respect appropriate restrictions on
    completions.

So I removed `pandoc.usage` from the repo. If you are looking for it,
the most recent version can be found [here][].

  [bash completion script]: http://www.hypexr.org/bash_tutorial.php#completion
  [pandoc]: http://johnmacfarlane.net/pandoc/
  [Compleat]: https://github.com/mbrubeck/compleat
  [here]: https://github.com/dsanson/pandoc-completion/commit/72eab2016eafa4957b1cfac07989d4f8ab208e4e
