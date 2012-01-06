## installation

First get pandoc-completion.bash,

    git clone git@github.com:dsanson/pandoc-completion.git

or (if you don't want to be bothered with git)

    curl -O https://raw.github.com/dsanson/pandoc-completion/master/pandoc-completion.bash

Then put something like

    [[ -s "/path/to/pandoc-completion.bash" ]] && source "/path/to/pandoc-completion.bash"

into your `.bashrc`.

## what it does 

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

Pandoc 1.9 introduced support for a `--citation-abbreviations` option, specifying a JSON file containing a list of abbreviations to be applied when generating bibliographies (e.g., abbreviations of Journal titles). For the moment, the script will complete filenames ending in `.json` in either ~/.csl or the current directory. This may change once I get a better sense of how these lists are used. 

## pandoc.usage has been discontinued

`pandoc.usage` was a usage file for use with [Compleat][], a haskell
program that generates bash and zsh completions based upon an abstract
specification of a command's command line option. I hoped it would ultimately provide a more elegant solution and be easier to maintain, but

1.  I couldn't get it to provide completions for full paths to files not in
    the current path;
2.  I couldn't get it to respect appropriate restrictions on completions.

So I removed pandoc.usage from the repo. The most recent version can be found [here](https://github.com/dsanson/pandoc-completion/commit/72eab2016eafa4957b1cfac07989d4f8ab208e4e).

  [Compleat]: https://github.com/mbrubeck/compleat
