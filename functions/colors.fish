function colors
    set option $argv[1]
    switch "$option"
        case '--ansi'
            colors::ansi
        case '--aixterm'
            colors::aixterm
        case '--256colors'
            colors::256colors
        case '--help'
            echo 'Usage: colors [option]'
            echo
            echo 'Available Options:'
            echo '  --help       Show this help'
            echo '  --ansi       Display ANSI colors table (default option)'
            echo '  --aixterm    Display aixterm high intensity colors table'
            echo '  --256colors  Display 256 colors table'
        case ''
            colors::ansi
        case '*'
            echo "colors: invalid option $option"
    end
end

function colors::ansi
    set text 'gYw'

    echo
    echo -e -n "\e[1mANSI Standard Colors\e[0m :\n"
    echo -e -n "  foreground: ESC[{\e[38;5;196m30-37\e[0m}m, bright foreground: ESC[1;{\e[38;5;196m30-37\e[0m}m\n"
    echo -e -n "  background: ESC[{\e[38;5;196m40-47\e[0m}m\n"

    echo -e -n "\n     "
    for BG in '   ' '40m' '41m' '42m' '43m' '44m' '45m' '46m' '47m'
        printf "   $BG  "
    end
    echo

    set foregrounds 'm' '1m' '30m' '1;30m' '31m' '1;31m' '32m' '1;32m' '33m' '1;33m' '34m' '1;34m' '35m' '1;35m' '36m' '1;36m' '37m' '1;37m'

    for i in (seq (count $foregrounds))
        set FG  $foregrounds[$i]
        printf " %5s \e[$FG  $text " $FG
        for BG in '40m' '41m' '42m' '43m' '44m' '45m' '46m' '47m';
            printf " \e[$FG\e[$BG  $text  \e[0m";
        end
        echo
    end
    echo
end

function colors::256colors

    echo
    echo -e -n "\e[1m256 Colors\e0m :\n"
    echo -e -n "  foreground: ESC[38;5;{\e[38;5;196m0-255\e[0m}m\n"
    echo -e -n "  background: ESC[48;5;{\e[38;5;196m0-255\e[0m}m\n"

    echo
    echo -e " \e[1mStandard Colors\e[0m :"
    for c in (seq 0 15)
        set bg (printf "48;5;%dm" $c)
        printf " \e[%s %3s \e[0m" $bg $c
        [ "$c" = '7' ]; and echo
    end
    echo

    echo
    echo -e " \e[1m216 Colors\e[0m :"
    for v in (seq 16 12 231)
        for h in (seq $v 1 231)[1..12]
            set bg (printf "48;5;%dm" $h)
            printf " \e[%s %3s \e[0m" $bg $h
        end
        echo
    end
    echo

    echo -e " \e[1mGrayscale Colors\e[0m :"
    for c in (seq 232 255)
        set bg (printf "48;5;%dm" $c)
        printf " \e[%s %3s \e[0m" $bg $c
        [ "$c" = '243' ]; and echo
    end
    echo -e "\n"
end

function colors::aixterm
    set text 'gYw'

    echo
    echo -e -n "\e[1mHigh Intensity Colors (aixterm)\e[0m :\n"
    echo -e -n "  foreground: ESC[{\e[38;5;196m90-97\e[0m}m\n"
    echo -e -n "  background: ESC[{\e[38;5;196m100-107\e[0m}m\n"

    echo -e -n "\n     "
    for BG in '    ' '100m' '101m' '102m' '103m' '104m' '105m' '106m' '107m'
        printf "  $BG  "
    end
    echo

    set foregrounds '90m' '91m' '92m' '93m' '94m' '95m' '96m' '97m'

    for i in (seq (count $foregrounds))
        set FG  $foregrounds[$i]
        printf " %5s \e[$FG  $text " $FG
        for BG in '100m' '101m' '102m' '103m' '104m' '105m' '106m' '107m';
            printf " \e[$FG\e[$BG  $text  \e[0m";
        end
        echo
    end
    echo
end
