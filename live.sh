#!/bin/bash

# Function to print a colored banner
print_colored_banner() {
    # ANSI escape codes for yellow text
    local yellow="\033[93m"
    local reset="\033[0m"
    local box_border="${yellow}+----------------------------------------+"

    # ASCII art
    local ascii_art="
                                    ___   ___
     /\\                            / _ \\ / _ \\
    /  \\   _ __   ___  _ __  _   _| | | | (_) |
   / /\\ \\ | '_ \\ / _ \\| '_ \\| | | | | | |> _ <
  / ____ \\| | | | (_) | | | | |_| | |_| | (_) |
 /_/    \\_\\_| |_|\\___/|_| |_|\\__, |\\___/ \\___/
                              __/ |
                             |___/
    "

    # Print the banner
    echo -e "$box_border"
    echo -e "${yellow}|                                      |"
    echo -e "${yellow}|       Credits: Siddiq Ahmad          |"
    echo -e "${yellow}|                                      |"
    echo -e "${yellow}|${ascii_art}  |"
    echo -e "${yellow}|                                      |"
    echo -e "$box_border"
    echo -e "$reset"
}

# Main function
main() {
    # ANSI escape codes for yellow text
    local yellow="\033[93m"
    local reset="\033[0m"

    # Print the banner
    print_colored_banner

    # Ask for the project name
    read -p "Enter the exact project name: " project_name

    # Define file paths
    local input_file="Targets/${project_name}/subs.txt"
    local output_file="Targets/${project_name}/live.txt"

    # Define the command to execute
    local command="cat $input_file | httpx-toolkit -ports 80,443,8080,8000,8888 -threads 200 -mc 200,403 -title -tech-detect | \
tee /dev/tty | grep -v 'Title: \\|Tech:' > $output_file && \
grep -oP 'http[s]?://\\S+' $output_file > Targets/${project_name}/alive.txt && \
rm $output_file"

    # Check if input file exists
    if [[ ! -f "$input_file" ]]; then
        echo -e "${yellow}File not found: $input_file. Check the project name or file path.${reset}"
        exit 1
    fi

    # Execute the command
    echo "Executing command:"
    echo "$command"
    if eval "$command"; then
        echo -e "${yellow}Successfully filtered live domains for project '$project_name' and saved to Targets/${project_name}/alive.txt.${reset}"
    else
        echo -e "${yellow}An error occurred during execution.${reset}"
    fi
}

# Main script execution
main
