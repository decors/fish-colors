function colors
    set option $argv[1]
    switch "$option"
        case '--syntax-examples'
            colors::syntax-examples
        case '--syntax-variables'
            colors::syntax-variables
        case '--ansi'
            colors::ansi
        case '--aixterm'
            colors::aixterm
        case '--256-colors'
            colors::256-colors
        case '--help'
            echo 'Usage: colors [option]'
            echo
            echo 'Available Options:'
            echo '  --help              Show this help'
            echo '  --syntax-examples   Display fish syntax color examples'
            echo '  --syntax-variables  Display fish syntax color variables'
            echo '  --ansi              Display ANSI colors table (default option)'
            echo '  --aixterm           Display aixterm high intensity colors table'
            echo '  --256-colors        Display 256 colors table'
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

function colors::256-colors

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

function colors::syntax-examples

    set -l desc_color "yellow --bold"

    function dummy_prompt
        printc "$fish_color_cwd" "/h/foo"
        printc normal " > "
    end

    printc "$desc_color" "\nValid commmand\n"
    dummy_prompt
    printc "$fish_color_command" "command\n"

    printc "$desc_color" "\nInvalid commmand\n"
    dummy_prompt
    printc "$fish_color_error" "comaand\n"

    printc "$desc_color" "\nParameters (normal, valid path)\n"
    dummy_prompt
    printc "$fish_color_command" "ls"
    printc "normal" " "
    printc "$fish_color_param" "-la"
    printc "normal" " "
    set_color $fish_color_param; set_color $fish_color_valid_path; printf "/var/log/\n"

    printc "$desc_color" "\nParameters (quote)\n"
    dummy_prompt
    printc "$fish_color_command" "printf"
    printc "normal" " "
    printc "$fish_color_quote" "\"%%s\\\n\"\n"

    printc "$desc_color" "\nAutosuggestion\n"
    dummy_prompt
    printc "$fish_color_command" "curl"
    printc "normal" " "
    printc "$fish_color_autosuggestion" "http://www.google.com/\n"

    printc "$desc_color" "\nCompletions\n"
    dummy_prompt
    printc "$fish_color_command" "fish\n"
    printc "$fish_pager_color_prefix" "fish"
    printc "normal" "                               "
    printc "$fish_pager_color_description" "(Executable link, 901kB)\n"
    printc "$fish_pager_color_prefix" "fish"
    printc "$fish_pager_color_completion" "_config\n"
    printc "$fish_pager_color_prefix" "fish"
    printc "$fish_pager_color_completion" "_default_key_bindings"
    printc "normal" "     "
    printc "$fish_pager_color_description" "(Default (Emacs-like) key b…)\n"
    printc "$fish_pager_color_prefix" "fish"
    printc "$fish_pager_color_completion" "_indent\n"
    printc "$fish_pager_color_progress" "…and 16 more rows\n"

    printc "$desc_color" "\nComments\n"
    dummy_prompt
    printc "$fish_color_command" "say"
    printc "normal" " "
    printc "$fish_color_param" "hello"
    printc "normal" " "
    printc "$fish_color_comment" "# Your Mac will speak\n"

    printc "normal" "\n"
end

function colors::syntax-variables
    printc "$fish_color_normal" "fish_color_normal\n"
    printc "$fish_color_command" "fish_color_command\n"
    printc "$fish_color_param" "fish_color_param\n"
    printc "$fish_color_redirection" "fish_color_redirection\n"
    printc "$fish_color_comment" "fish_color_comment\n"
    printc "$fish_color_error" "fish_color_error\n"
    printc "$fish_color_escape" "fish_color_escape\n"
    printc "$fish_color_operator" "fish_color_operator\n"
    printc "$fish_color_end" "fish_color_end\n"
    printc "$fish_color_quote" "fish_color_quote\n"
    printc "$fish_color_autosuggestion" "fish_color_autosuggestion\n"
    printc "$fish_color_valid_path" "fish_color_valid_path\n"
    printc "$fish_color_cwd" "fish_color_cwd\n"
    printc "$fish_color_cwd_root" "fish_color_cwd_root\n"
    printc "$fish_color_match" "fish_color_match\n"
    printc "$fish_color_search_match" "fish_color_search_match\n"
    printc "$fish_color_selection" "fish_color_selection\n"
    printc "$fish_pager_color_prefix" "fish_pager_color_prefix\n"
    printc "$fish_pager_color_completion" "fish_pager_color_completion\n"
    printc "$fish_pager_color_description" "fish_pager_color_description\n"
    printc "$fish_pager_color_progress" "fish_pager_color_progress\n"
    printc "$fish_color_history_current" "fish_color_history_current\n"
end

function printc -a color text
    set_color normal
    set_color -b normal
    eval "set_color $color"
    printf $text
end