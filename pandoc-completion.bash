# pandoc completion 
# 
# (c) 2012, 2013 David Sanson
# 
# Copying and distribution of this file, with or without modification,
# are permitted in any medium without royalty provided the copyright
# notice and this notice are preserved.  This file is offered as-is,
# without any warranty.
#
# Pandoc Version: 1.11
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
    
    extensible="markdown markdown_strict markdown_phpextra  \
        markdown_github markdown_mmd"

    input="native json rst mediawiki docbook \
        textile html latex"

    input="$input $extensible"

    output="native json docx odt epub epub3 fb2 html html5 \
        s5 slidy slideous dzslides docbook opendocument \
        latex beamer context texinfo man plain \
        rst mediawiki textile rtf org asciidoc"

    output="$output $extensible"

    extensions="escaped_line_breaks blank_before_header header_attributes \
        auto_identifiers implicit_header_references \
        blank_line_before_blockquote fenced_code_blocks line_blocks \
        fancy_lists startnum definition_lists example_lists simple_tables \
        multiline_tables grid_tables pandoc_title_block \
        all_symbols_escapable intraword_underscores strikeout superscript \
        subscript inline_code_attributes tex_math_dollars raw_html \
        markdown_in_html_blocks raw_tex latex_macros implicit_figures \
        footnotes inline_notes citations hard_line_breaks \
        tex_math_single_backslash tex_math_double_backslash markdown_attribute \
        mmd_title_block abbrevations autolink_bare_uris link_attributes \
        mmd_header_identifiers"

    bibs="(bib)|(mods)|(ris)|(bbx)|(enl)|(xml)|(wos)|(copac)|(json)|(medline)"

    highlight_styles="pygments kate monochrome espresso zenburn haddock tango"

    latex_engines="pdflatex lualatex xelatex"

    pandoc_opts="-f -r --from --read\
                -t -w --to --write \
                -o --output \
                --data-dir \
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
                --toc-depth \
                --no-highlight \
                --highlight-style \
                -H --include-in-header \
                -B --include-before-body \
                -A --include-after-body \
                --self-contained \
                --offline \
                -5 --html5 \
                --html-q-tags \
                --ascii \
                --reference-links \
                --atx-headers \
                --chapters \
                -N --number-sections \
                --number-offset \
                --no-tex-ligatures
                --listings \
                -i --incremental \
                --slide-level \
                --section-divs \
                --default-image-extension \
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
                --epub-chapter-level \
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
            if [[ $cur == *[+-] ]]
            then
                suggestions=""
                for e in $extensions
                do
                    suggestions="$cur$e $suggestions"
                done
                COMPREPLY=( $( compgen -W "$suggestions" -- ${cur} ) )
            elif [[ $cur == *[+-]* ]]
            then
                suggestions=""
                root=${cur%[+-]*}
                suffix=${cur##*[+-]}
                connective=${cur#$root}
                connective=${connective:0:1}
                for e in $extensions
                do
                    suggestions="$root$connective$e $suggestions"
                done
                COMPREPLY=( $( compgen -W "$suggestions" -- ${cur} ) )
            else
                COMPREPLY=( $( compgen -W "$input" -- ${cur} ) )
            fi
            return 0
            ;;
        -t|-w|-D|--to|--write|--print-default-template)
            if [[ $cur == *[+-] ]]
            then
                suggestions=""
                for e in $extensions
                do
                    suggestions="$cur$e $suggestions"
                done
                COMPREPLY=( $( compgen -W "$suggestions" -- ${cur} ) )
            elif [[ $cur == *[+-]* ]]
            then
                suggestions=""
                root=${cur%[+-]*}
                suffix=${cur##*[+-]}
                connective=${cur#$root}
                connective=${connective:0:1}
                for e in $extensions
                do
                    suggestions="$root$connective$e $suggestions"
                done
                COMPREPLY=( $( compgen -W "$suggestions" -- ${cur} ) )
            else
                COMPREPLY=( $( compgen -W "$output" -- ${cur} ) )
            fi
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
            COMPREPLY=( $( ls $HOME/.pandoc/templates/ 2> /dev/null | grep "^${cur}" ) )
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

