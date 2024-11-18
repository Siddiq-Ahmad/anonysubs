#!/bin/bash

# Function to print a colored banner
print_colored_banner() {
    # ANSI escape codes for yellow text and box border
    local yellow="\033[93m"
    local reset="\033[0m"
    local box_border="${yellow}+----------------------------------------+"

    # Your ASCII art
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

    # Print the banner in a colored box
    echo -e "$box_border"
    echo -e "${yellow}|                                      |"
    echo -e "${yellow}|${ascii_art}  |"
    echo -e "${yellow}|                                      |"
    echo -e "${yellow}|       Credits: Siddiq Ahmad          |"
    echo -e "$box_border"
    echo -e "$reset"
}

# Function to create a project
create_project() {
    # Prompt the user for the domain and project name
    read -p "Enter the domain: " domain
    read -p "Enter the project name: " project_name

    # Define the target folder path
    local targets_folder="Targets"

    # Create the project directory inside Targets
    local project_path="${targets_folder}/${project_name}"
    mkdir -p "$project_path"

    # Define the command to execute
    local command="sublist3r -d $domain -o ${project_path}/subs.txt && \
subfinder -d $domain -o ${project_path}/subs.txt && \
findomain -t $domain -u ${project_path}/subs.txt && \
assetfinder -subs-only $domain >> ${project_path}/subs.txt && \
sort ${project_path}/subs.txt | uniq > ${project_path}/temp.txt && \
mv ${project_path}/temp.txt ${project_path}/subs.txt"

    # Execute the command
    echo "Executing command:"
    echo "$command"
    if eval "$command"; then
        echo "Command executed successfully."
    else
        echo "An error occurred while executing the command."
    fi
}

# Main script execution
print_colored_banner  # Display the banner
create_project         # Call the create_project function
