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
    local cur prev opts
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

    inputafter="-f -r --from= --read="

	outputafter="-t -w -D --to= --write= --print-default-template="
    
	urlafter="--css= --latexmathml= --asciimathml= \
		--mathml= --mimetex= --webtex= --jsmath= --mathjax="

	fileafter="--output= --template= \
		--include-in-header= --include-before-body= \
		--include-after-body= --reference-odt= --epub-stylesheet= \
		--epub-cover-image= --epub-metadata= --bibliography= --csl= \
		-o -H -B -A"

	directoryafter="--data-dir="

	opts="-f -r -t -w -o -s --standalone -p --preserve-tabs \
	--strict --normalize --reference-links -R --parse-raw -S --smart \
	-5 --html5 --gladtex -i --incremental --offline --xetex --chapters \
	-N --number-sections --listings --section-divs --no-wrap \
	--ascii --toc --table-of-contents -V -c -T \
	--natbib --biblatex --dump-args --ignore-args \
	-v --version -h --help -m --latexmathml --asciimathml \
	--mathml --mimetex --webtex --jsmath --mathjax \
	--tab-stop= --columns= --id-prefix= \
    --indented-code-classes=  --base-header-level= \
    --variable= --title-prefix= --email-obfuscation=" 
	
	opts="$opts $inputafter $outputafter $urlafter $fileafter \ 
	     $directoryafter"
    
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
			texpath=$(kpsewhich -var-value TEXMFHOME)
			COMPREPLY=(  ${COMPREPLY[@]} $( ls ${texpath} 2> /dev/null | egrep "(.bib$)|(.mods$)|(.ris$)|(.bbx$)|(.enl$)|(.xml$)|(.wos$)|(.copac$)|(.json$)|(.medline$)" 2> /dev/null | sed 's#^#'${texpath}'/.pandoc/#' 2> /dev/null | grep ${cur} 2> /dev/null ) )
			COMPREPLY=( ${COMPREPLY[@]} $(compgen -f -- ${cur}))
			return 0
			;;
		--template)
			COMPREPLY=( $(ls $HOME/.pandoc/ 2> /dev/null | grep ".template$" 2> /dev/null | sed s#$HOME/.pandoc/## 2> /dev/null | sed s/.template$// 2> /dev/null | grep ${cur} 2> /dev/null) )
			COMPREPLY=( $(ls $HOME/.pandoc/templates/ 2> /dev/null | grep ".template$" | sed s#$HOME/.pandoc/templates/## 2> /dev/null | sed s/.template$// 2> /dev/null | grep ${cur} 2> /dev/null ))
			COMPREPLY=( ${COMPREPLY[@]} $(compgen -f -- ${cur}))
			return 0
			;;
		--csl)
			COMPREPLY=( $(ls $HOME/.csl/ 2> /dev/null | grep ${cur} 2> /dev/null ))
			COMPREPLY=( ${COMPREPLY[@]} $(compgen -f -- ${cur}))
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

complete -F _completer -o nospace pandoc
