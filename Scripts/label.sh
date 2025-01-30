#!/usr/bin/env zsh

# Function to echo text with specified styles. Only Zsh is supported.
# Example: `label "dim bold red" "Hello world!"`
label() {
    local -r style_string="$1"
    shift  # remove the first argument, leaving only the text to be styled
    local text="$*"
    local codes=""
    local -r reset_code="\033[0m"
    local code_str=""
    local output_fd=1  # default to stdout
    local unknown_styles=()

    # check if running in Zsh
    if [[ -n "${ZSH_VERSION:-}" ]]; then
        # use Zsh-specific features
        typeset -A styles
        styles=(
            [reset]="\033[0m" [bold]="\033[1m" [dim]="\033[2m"
            [italic]="\033[3m" [underline]="\033[4m" [blink]="\033[5m"
            [reverse]="\033[7m" [hidden]="\033[8m" [strike]="\033[9m"
            [red]="\033[31m" [green]="\033[32m" [yellow]="\033[33m"
            [blue]="\033[34m" [magenta]="\033[35m" [cyan]="\033[36m"
            [white]="\033[37m"
        )

        local -a styles_requested=("${(s: :)style_string}")

        for style in $styles_requested; do
            case "${style}" in
                stdout) output_fd=1 ;;

                stderr) output_fd=2 ;;

                *)
                # Check if the style exists in the styles array
                if [[ -n "${styles[${style}]}" ]]; then
                    codes+="${styles[${style}]}"
                else
                    unknown_styles+=("${style}")
                fi
                ;;
            esac
        done
    else
        # fallback for non-Zsh shells
        echo "${text}" >&$output_fd
        return
    fi

    # construct final sequence
    code_str=${codes}

    # wrap text with unknown styles as XML-like tags if any
    for tag in ${(Oa)unknown_styles}; do
        text="<${tag}>${text}</${tag}>"
    done

    # print the styled text
    echo -e "${code_str}${text}${reset_code}" >&$output_fd
}
