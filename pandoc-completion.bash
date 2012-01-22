# pandoc completion 
# 
# (c) 2011 David Sanson
# 
# Copying and distribution of this file, with or without modification,
# are permitted in any medium without royalty provided the copyright
# notice and this notice are preserved.  This file is offered as-is,
# without any warranty.
#

function _completer() 
{
    local command cur prev opts
    command="$1"
    COMPREPLY=()
    cur="${COMP_WORDS[COMP_CWORD]}"
    prev="${COMP_WORDS[COMP_CWORD-1]}"
    if [ ${prev} == '=' ]
    then
       prev="${COMP_WORDS[COMP_CWORD-2]}"
    fi
    
    input="native json markdown markdown+lhs rst rst+lhs textile \
        html latex latex+lhs"

    output="native json html html5 html+lhs html5+lhs s5 slidy \
        dzslides docbook \
        opendocument latex latex+lhs context texinfo man \ 
        markdown markdown+lhs plain rst rst+lhs mediawiki \ 
        textile rtf org asciidoc odt docx epub pdf"

    bibs="(bib)|(mods)|(ris)|(bbx)|(enl)|(xml)|(wos)|(copac)|(json)|(medline)"

    highlight_styles="pygments kate monochrome espresso haddock tango"

    latex_engines="pdflatex lualatex xelatex"

    pandoc_opts="-f -r --from --read \
                 -t -w --to --write \
                 -s --standalone \
                 -o --output \
                 -p --preserve-tabs \
                 --tab-stop \
                 --strict \
                 --normalize \
                 --reference-links \
                 -R --parse-raw \
                 -S --smart \
                 --old-dashes \
                 -5 --html5 \
                 --no-highlight \
                 --highlight-style \
                 -m --latexmathml \
                 --mathml \
                 --mimetex \
                 --webtex \
                 --jsmath \}
                 --mathjax \
                 --gladtex \
                 -i --incremental \
                 --offline \
                 --self-contained \
                 --chapters \
                 -N --number-sections \
                 --listings \
                 --beamer \
                 --section-divs \
                 --no-wrap \
                 --columns \
                 --email-obfuscation \
                 --id-prefix \
                 --indented-code-classes \
                 --toc --table-of-contents \
                 --base-header-level \
                 --template \
                 -V --variable \
                 -c --css \
                 -H --include-in-header \
                 -B --include-before-body \
                 -A --include-after-body \
                 -T --title-prefix \
                 --reference-odt \
                 --reference-docx \
                 --epub-stylesheet \
                 --epub-cover-image \
                 --epub-metadata \
                 --latex-engine \
                 -D --print-default-template \
                 --bibliography \
                 --csl \
                 --citation-abbreviations \
                 --natbib \
                 --biblatex \
                 --data-dir \
                 --dump-args \
                 --ignore-args \
                 -v --version \
                 -h --help"

    markdown2pdf_opts="--xetex --luatex --beamer \
                -f -r --from --read \
                -o --output \
                -p --preserve-tabs \
                --tab-stop \
                --strict \
                -R --parse-raw \
                --old-dashes \
                --no-highlight \
                --highlight-style \
                -N --number-sections \
                --listings \
                --toc --table-of-contents \
                --template \
                -V --variable \
                -H --include-in-header \
                -B --include-before-body \
                -A --include-after-body \
                --bibliography \
                --csl \
                --citation-abbreviations \
                --data-dir \
                -h --help"

    if [ "$command" == "pandoc" ]
    then
        opts="$pandoc_opts"
    elif [ "$command" == "markdown2pdf" ]
    then
        opts="$markdown2pdf_opts"
    else
        return 0
    fi
    
    case "$prev" in
        -f|-r|--from|--read)
            COMPREPLY=( $( compgen -W "$input" -- ${cur} ) )
            return 0
            ;;
        -t|-w|-D|--to|--write|--print-default-template)
            COMPREPLY=( $( compgen -W "$output" -- ${cur} ) )
            return 0
            ;;
        --highlight-style)
            COMPREPLY=( $( compgen -W "$highlight_styles" -- ${cur} ) )
            return 0
            ;;
        --latex-engine)
            COMPREPLY=( $( compgen -W "$latex_engines" -- ${cur} ))
            return 0
            ;;
        --data-dir)
            COMPREPLY=( $( compgen -d -- ${cur} ) )
            return 0
            ;;
        --email-obfuscation)
            COMPREPLY=( $( compgen -W "none javascript references" -- ${cur} ) )
            return 0
            ;;
        --bibliography)
            COMPREPLY=( $( ls $HOME/.pandoc/ 2> /dev/null | egrep "^${cur}.*\.${bibs}$" | sed "s#^#$HOME/.pandoc/#" ) )
            COMPREPLY=( ${COMPREPLY[@]} $(compgen -f -- ${cur} | egrep "\.${bibs}$" ) )
            return 0
            ;;
        --template)
            if [ ${command} == 'pandoc' ]; then
                COMPREPLY=( $( ls $HOME/.pandoc/templates/ 2> /dev/null | grep "^${cur}" ) )
            elif [ ${command} == 'markdown2pdf' ]; then
                COMPREPLY=( $( ls $HOME/.pandoc/templates/ 2> /dev/null | grep "latex" | grep "^${cur}" ) )
            fi
            COMPREPLY=( ${COMPREPLY[@]} $(compgen -f -- ${cur} ) )
            return 0
            ;;
        --csl)
            COMPREPLY=( $( ls $HOME/.csl/ 2> /dev/null | egrep "^${cur}.*\.csl$" ) )
            COMPREPLY=( ${COMPREPLY[@]} $(compgen -f -- ${cur} | grep ".csl$" ) ) 
            return 0
            ;;
        --citation-abbreviations)
            COMPREPLY=( $( ls $HOME/.csl/ 2> /dev/null | egrep "^${cur}.*\.json$" | sed "s#^#$HOME/.csl/#" ) )
            COMPREPLY=( ${COMPREPLY[@]} $(compgen -f -- ${cur} | grep ".json$" ) )
            return 0
            ;;
        --reference-odt)
            COMPREPLY=( $( ls $HOME/.pandoc/ 2> /dev/null | egrep "^${cur}.*\.odt$" | sed s#^#$HOME/.pandoc/# ) )
            COMPREPLY=( ${COMPREPLY[@]} $(compgen -f -- ${cur} ) )
            return 0
            ;;

        -o|--output)
            COMPREPLY=( $( compgen -f -- ${cur} ) )
            return 0
            ;;
    esac

    case "$cur" in
        -*)
          COMPREPLY=( $(compgen -W "$opts" -- ${cur}) )
          return 0
          ;;
        *)
          COMPREPLY=( $(compgen -f -- ${cur}) )
          ;;
    esac
}

function _pandoc_completer() {
    _completer pandoc
    return 0
}

function _markdown2pdf_completer() {
    _completer markdown2pdf
}

complete -F _pandoc_completer -o nospace pandoc

complete -F _markdown2pdf_completer -o nospace markdown2pdf
