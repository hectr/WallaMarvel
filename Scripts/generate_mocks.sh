#!/usr/bin/env zsh

################################################################################
# Prepare environment
################################################################################

# Function to echo script description.
function help() {
    label "" ""
    label "dim" "Generates mocks for the protocols of the given target."
    label "dim" "Output file path and additional imports are customizable."
    label "" ""

    exit 0
}

# Function to echo script usage.
function usage() {
    local -r script="${1}"
    local -r argument="${2}"

    label "stderr" ""
    label "stderr red" "Invalid argument: ${argument}"
    label "stderr red" "Usage: ${script} [generate|help] [--debug] --target=<target_name> [--sources-path=<sources_path>] [--import=<import_name>...] [--testable-import=<import_name>...] [--output=<output_file_path>]"
    label "stderr" ""

    exit "${LINENO}"
}

# exit immediately when a command fails
set -Eeo pipefail

# treat unset variables as an error
set -u

readonly scripts_path="$( cd "$(dirname "${0}")" ; pwd -P )"
readonly root_repository_path="$( cd "${scripts_path}"; git rev-parse --show-toplevel )"

# import dependencies
source "${scripts_path}/label.sh"

################################################################################
# Parse arguments
################################################################################

target_name=""
imports=()
output=""
sources_path="${root_repository_path}/Sources"

for argument in "$@"; do
    if [[ "${argument}" == "--debug" ]]; then set -x

    elif [[ "${argument}" == "--target="* ]]; then target_name="${argument#--target=*}" && imports+="@testable import ${target_name}"

    elif [[ "${argument}" == "--sources-path="* ]]; then sources_path="${argument#--sources-path=*}"

    elif [[ "${argument}" == "--import="* ]]; then imports+=("import ${argument#--import=}")

    elif [[ "${argument}" == "--testable-import="* ]]; then imports+=("@testable import ${argument#--testable-import=}")

    elif [[ "${argument}" == "--output="* ]]; then output="${argument#--output=*}"

    elif [[ "${argument}" == "help" ]]; then help

    elif [[ "${argument}" != "generate" ]]; then usage "${0}" "${argument}"; fi
done

################################################################################
# Customize output
################################################################################

# Function to insert calling command and custom imports at the third line of the output file.
function customize_output_file() {
    local -r output_file_path="${1}"
    local -r command_line_string="${2}"
    local -r import_lines_string="${3}"

    # Read the current content of the output file into an array using a while loop
    file_lines=()
    while IFS= read -r line; do
        file_lines+=("$line")
    done < "${output_file_path}"

    # Insert the command and imports at the third line
    {
        # Ensure there are at least two lines to begin with
        if [ ${#file_lines[@]} -ge 2 ]; then
            echo "${file_lines[1]}"   # First line (Zsh arrays start at 1)
            echo "${file_lines[2]}"   # Second line
        fi

        # Output the command and imports
        echo ""
        echo "${command_line_string}"
        echo ""
        echo -n "${import_lines_string}"

        # Output the rest of the file starting from the third line
        if [ ${#file_lines[@]} -gt 2 ]; then
            for i in {3..${#file_lines[@]}}; do
                echo "${file_lines[i]}"
            done
        fi
    } > "${output_file_path}.tmp" && mv "${output_file_path}.tmp" "${output_file_path}"
}

# Prepare command
readonly command_line_string="// Command: $0 $*"

# Prepare import lines
import_lines_string=""
for import in "${imports[@]}"; do
    import_lines_string+="${import}\n"
done

################################################################################
# Execute
################################################################################

# change directory to repository root
cd "${root_repository_path}"

readonly sources="${sources_path}/${target_name}"
readonly templates="${scripts_path}/templates"
readonly default_output_filename="${target_name}_mocks.generated.swift"
readonly default_output="${sources_path}/${target_name}TestSupport/${default_output_filename}"
readonly final_output="${output:-$default_output}"

# execute Sourcery
sourcery --sources "${sources}"     \
         --templates "${templates}" \
         --output "${final_output}"

# Insert command and imports into output file
customize_output_file "${final_output}" "${command_line_string}" "${import_lines_string}"
