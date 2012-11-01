# pandoc completion 
# 
# (c) 2012 David Sanson
# 
# Copying and distribution of this file, with or without modification,
# are permitted in any medium without royalty provided the copyright
# notice and this notice are preserved.  This file is offered as-is,
# without any warranty.
#
# Pandoc Version: 1.9.4.5
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
    
    input="native json markdown markdown+lhs rst rst+lhs docbook \
        textile html latex latex+lhs"

    output="native json html html5 html+lhs html5+lhs s5 slidy \
        slideous dzslides docbook opendocument latex latex+lhs beamer \
        beamer+lhs context texinfo man markdown markdown+lhs \
        plain rst rst+lhs mediawiki textile rtf org asciidoc \
        odt docx epub"

    bibs="(bib)|(mods)|(ris)|(bbx)|(enl)|(xml)|(wos)|(copac)|(json)|(medline)"

    highlight_styles="pygments kate monochrome espresso zenburn haddock tango"

    latex_engines="pdflatex lualatex xelatex"

    pandoc_opts="-f -r --from --read\
                -t -w --to --write \
                -o --output \
                --data-dir \
                --strict \
                -R --parse-raw \
                -S --smart \
                --old-dashes \
                --base-header-level \
                --indented-code-classes \
                --normalize \
                -p --preserve-tabs \
                --tab-stop \
                -s --standalone \
                --template \
                -V --variable \
                -D --print-default-template \
                --no-wrap \
                --columns \
                --toc --table-of-contents \
                --no-highlight \
                --highlight-style \
                -H --include-in-header \
                -B --include-before-body \
                -A --include-after-body \
                --self-contained \
                --offline \
                -5 --html5 \
                --ascii \
                --reference-links \
                --atx-headers \
                --chapters \
                -N --number-sections \
                --no-tex-ligatures
                --listings \
                -i --incremental \
                --slide-level \
                --section-divs \
                --email-obfuscation \
                --id-prefix \
                -T --title-prefix \
                -c --css \
                --reference-odt \
                --reference-docx \
                --epub-stylesheet \
                --epub-cover-image \
                --epub-metadata \
                --epub-embed-font \
                --latex-engine \
                --bibliography \
                --csl \
                --citation-abbreviations \
                --natbib \
                --biblatex \
                -m --latexmathml --asciimathml \
                --mathml \
                --mimetex \
                --webtex \
                --jsmath \
                --mathjax \
                --gladtex \
                --dump-args \
                --ignore-args \
                -v --version \
                -h --help"

    if [ "$command" == "pandoc" ]
    then
        opts="$pandoc_opts"
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
            COMPREPLY=( ${COMPREPLY[@]} $(compgen -f -- ${cur} | egrep "*.odt" ) )
            return 0
            ;;
        --reference-docx)
            COMPREPLY=( $( ls $HOME/.pandoc/ 2> /dev/null | egrep "^${cur}.*\.docx$" | sed s#^#$HOME/.pandoc/# ) )
            COMPREPLY=( ${COMPREPLY[@]} $(compgen -f -- ${cur} | egrep "*.docx" ) )
            return 0
            ;;
        -o|--output)
            COMPREPLY=( $( compgen -f -- ${cur} | sed "s/\(.*\)\..*/\1/" | grep "${cur}"; compgen -f -- ${cur} ) )
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

complete -F _pandoc_completer -o nospace pandoc

