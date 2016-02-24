function colors
    set text 'gYw'
    
    echo -e -n "\n     "
    for BG in '   ' '40m' '41m' '42m' '43m' '44m' '45m' '46m' '47m'
        printf "   $BG  "
    end
    echo
    
    set foregrounds 'm' '1m' '30m' '1;30m' '31m' '1;31m' '32m' '1;32m' '33m' '1;33m' '34m' '1;34m' '35m' '1;35m' '36m' '1;36m' '37m' '1;37m'
    
    for i in (seq (count $foregrounds))
        set FG  $foregrounds[$i]
        printf " %5s \033[$FG  $text " $FG
        for BG in '40m' '41m' '42m' '43m' '44m' '45m' '46m' '47m';
            printf " \033[$FG\033[$BG  $text  \033[0m";
        end
        echo
    end
    echo
end
