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

    output="native json html html+lhs s5 slidy docbook \
		opendocument latex latex+lhs context texinfo man \ 
	    markdown markdown+lhs plain rst rst+lhs mediawiki \ 
		textile rtf org odt epub"

	pandoc_opts=" -t -w -D --to --write \
		        -s --standalone \
				--normalize \
				--reference-links \
				-S --smart \
				-5 --html5 \
				-m --latexmathml \
				--mathml \
				--mimetex \
				--webtex \
				--jsmath \}
				--mathjax \
				--gladtex \
				-i --incremental \
				--offline \
				--chapters \
				--section-divs \
				--no-wrap \
				--columns \
				--ascii \
				--email-obfuscation \
				--id-prefix \
				--indented-code-classes \
				--base-header-level \
				-c --css \
				--reference-odt \
				--epub-stylesheet \
			    --epub-cover-image \
				--epub-metadata \
				-D --print-default-template \
				-T --title-prefix \
				--natbib \
				--biblatex \
				--dump-args \
				--ignore-args \
				-v --version"

	shared_opts="-f -r --from --read \
		        -o --output \
		        -p --preserve-tabs \
				--tab-stop \
			    --strict \
				-R --parse-raw \
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
				--data-dir \
				-h --help"

    if [ "$command" == "pandoc" ]
	then
		opts="$pandoc_opts $shared_opts"
	elif [ "$command" == "markdown2pdf" ]
	then
		opts="$shared_opts"
	else
		return 0
	fi
    
	case "$prev" in
		-f|-r|--from|--read)
			COMPREPLY=( $(compgen -W "$input" -- ${cur} ) )
			return 0
			;;
		-t|-w|-D|--to|--write|--print-default-template)
			COMPREPLY=( $(compgen -W "$output" -- ${cur} ) )
			return 0
			;;
		--data-dir)
			COMPREPLY=( $(compgen -d -- ${cur}))
			return 0
			;;
		--email-obfuscation)
			COMPREPLY=( $(compgen -W "none javascript references" -- ${cur}))
			return 0
			;;
		--bibliography)
			COMPREPLY=( $( ls $HOME/.pandoc/ 2> /dev/null | egrep "(.bib$)|(.mods$)|(.ris$)|(.bbx$)|(.enl$)|(.xml$)|(.wos$)|(.copac$)|(.json$)|(.medline$)" 2> /dev/null | sed "s#^#$HOME/.pandoc/#" 2> /dev/null | grep ${cur} 2> /dev/null ) )
			COMPREPLY=( ${COMPREPLY[@]} $(compgen -f -- ${cur}))
			return 0
			;;
		--template)
			COMPREPLY=( $(ls $HOME/.pandoc/templates/ 2> /dev/null | sed s#$HOME/.pandoc/templates/## 2> /dev/null | grep ${cur} 2> /dev/null ))
			COMPREPLY=( ${COMPREPLY[@]} $(compgen -f -- ${cur}))
			return 0
			;;
		--csl)
			COMPREPLY=( $(ls $HOME/.csl/ 2> /dev/null | grep ".csl$" | grep ${cur} 2> /dev/null ))
			COMPREPLY=( ${COMPREPLY[@]} $(compgen -f -- ${cur} | grep ".csl$" ))
			return 0
			;;
		--reference-odt)
			COMPREPLY=( $(ls $HOME/.pandoc/ 2> /dev/null | grep ".odt$" 2> /dev/null | sed s#$HOME/.pandoc/## 2> /dev/null | grep ${cur} 2> /dev/null) )
			COMPREPLY=( ${COMPREPLY[@]} $(compgen -f -- ${cur}))
			return 0
			;;

		-o|--output)
			COMPREPLY=( $(compgen -f -- ${cur}))
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
