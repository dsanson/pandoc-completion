pandoc-completion.bash
----------------------

`pandoc-completion.bash` is a [bash completion script][] for [pandoc][].
It supports completion of `pandoc`'s command-line options, as well as
completion of filenames in the pandoc data directory, `~/.pandoc`, and
the csl styles directory, `~/.csl`, where appropriate.

installation
------------

First get `pandoc-completion.bash`,

    git clone git@github.com:dsanson/pandoc-completion.git

or (if you don't want to be bothered with git)

    curl -O https://raw.github.com/dsanson/pandoc-completion/master/pandoc-completion.bash

Then put something like

    [[ -s "/path/to/pandoc-completion.bash" ]] && source "/path/to/pandoc-completion.bash"

in your `.bashrc`.

To use bash completion scripts with [zsh][], you need to load `bashcompinit` first, so put something like

```bash

autoload bashcompinit
bashcompinit
source "/path/to/pandoc-completion.bash"

```

in your `.zshrc`.

which version of pandoc?
------------------------

New versions of pandoc sometimes bring new command-line options and sometimes remove old command-line options. I have not been as careful about keeping track of this as I might have been: I usually use the development version of pandoc, updating every couple of weeks. And I try to keep this script in sync with what I am using.

In recent commits, you will find a line like this

```bash
# Pandoc Version: 1.10.0.3
```

at the beginning of the script. The script should exactly match the options available in that version of pandoc. Since the command-line options are fairly stable, you probably don't need to worry about this too much.

A good quick way to check your version of pandoc against your version of pandoc-completion.bash is to run `pandoc --help`, and compare the output against the completion script, looking to see if the input and output formats match and if the options match.

some further details about the implementation
---------------------------------------------

The script completes long options that take arguments as

    --opt arg

rather than

    --opt=arg

(although the documentation doesn't don't make this clear, `pandoc`
supports both styles). But if you type something like

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
-   `--reference-odt` and `--reference-docx`: filenames ending in `.odt`
    or `.docx` in the current directory or `~/.pandoc`.

adding your own completion shortcuts
------------------------------------

If there is an option that you use regularly, you might want to create a completion shortcut for it. For example, in my personal copy of `pandoc-completions.bash`, I have added two instances to the case-loop that occurs near the end of the script, so that `-x` expands to `--latex-engine xelatex` and `-b` expands to `--bibliography $HOME/.pandoc/default.bib`: 

```bash
case "$cur" in
    -x)
      COMPREPLY=( "--latex-engine xelatex" )
      return 0
      ;;
    -b)
      COMPREPLY=( "--bibliography $HOME/.pandoc/default.bib")
      return 0
      ;;
    -*)
      COMPREPLY=( $(compgen -W "$opts" -- ${cur}) )
      return 0
      ;;
    *)
      COMPREPLY=( $(compgen -f -- ${cur}) )
      ;;
esac
```

pandoc.usage
------------

This repository used to include both `pandoc-completion.bash` and
`pandoc.usage`. The latter was a usage file for use with
[Compleat][], a haskell program that generates bash and zsh completions
based upon an abstract specification of a command's command line options.
I hoped it would ultimately provide a more elegant solution and be
easier to maintain, but

1.  I couldn't get it to provide completions for full paths to files not
    in the current directory;
2.  I couldn't get it to respect appropriate restrictions on
    completions.

So I removed `pandoc.usage` from the repo. If you are looking for it,
the most recent version can be found [here][]. If you can get it to work, let me know!

  [bash completion script]: http://www.hypexr.org/bash_tutorial.php#completion
  [pandoc]: http://johnmacfarlane.net/pandoc/
  [zsh]: http://zsh.sourceforge.net/
  [Compleat]: https://github.com/mbrubeck/compleat
  [here]: https://github.com/dsanson/pandoc-completion/commit/72eab2016eafa4957b1cfac07989d4f8ab208e4e
