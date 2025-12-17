#!/bin/bash

# Function to print a colored banner
print_colored_banner() {
    local yellow="\033[93m"
    local reset="\033[0m"
    local box_border="${yellow}+----------------------------------------+"

    local ascii_art="
  /$$$$$$            /$$             /$$$$$$$$
 /$$__  $$          | $$            |__  $$__/
| $$  \\__/ /$$   /$$| $$$$$$$          | $$  /$$$$$$  /$$$$$$   /$$$$$$$  /$$$$$$
|  $$$$$$ | $$  | $$| $$__  $$         | $$ /$$__  $$|____  $$ /$$_____/ /$$__  $$
 \\____  $$| $$  | $$| $$  \\ $$         | $$| $$  \\__/ /$$$$$$$| $$      | $$$$$$$$
 /$$  \\ $$| $$  | $$| $$  | $$         | $$| $$      /$$__  $$| $$      | $$_____/
|  $$$$$$/|  $$$$$$/| $$$$$$$/         | $$| $$     |  $$$$$$$|  $$$$$$$|  $$$$$$$
 \\______/  \\______/ |_______/          |__/|__/      \\_______/ \\_______/ \\_______/



    "

    echo -e "$box_border"
    echo -e "${yellow}|                                      |"
    echo -e "${yellow}|${ascii_art}  |"
    echo -e "${yellow}|                                      |"
    echo -e "${yellow}|       Credits: Siddiq Ahmad          |"
    echo -e "$box_border"
    echo -e "$reset"
}

# Function to enumerate subdomains for a domain
enumerate_domain() {
    local domain=$1
    local output_file=$2

    echo "Enumerating subdomains for $domain..."

    subfinder -d "$domain" -o - | tee -a "$output_file"
    assetfinder --subs-only "$domain" | tee -a "$output_file"
    findomain -t "$domain" -u "$output_file"
    amass enum -passive -d "$domain" | tee -a "$output_file"

    # crt.sh
    curl -s "https://crt.sh?q=${domain}&output=json" | \
        jq -r '.[].name_value' | \
        grep -Po '(\\w+\\.\\w+\\.\\w+)$' >> "$output_file"

    # web.archive.org
    curl -s "http://web.archive.org/cdx/search/cdx?url=*.$domain/*&output=text&fl=original&collapse=urlkey" | \
        sed -e 's_https*://__' -e 's/\\/.*//' -e 's/:.*//' -e 's/^www\\.//' | \
        sort -u >> "$output_file"

    echo "Subdomain enumeration done for $domain."
}

# Single domain mode
single_domain_mode() {
    read -p "Enter the domain: " domain
    read -p "Enter the project name: " project_name

    local targets_folder="Targets"
    local project_path="${targets_folder}/${project_name}"
    mkdir -p "$project_path"

    local output_file="${project_path}/subs.txt"
    local resolved_file="${project_path}/resolved.txt"

    enumerate_domain "$domain" "$output_file"
    sort -u "$output_file" -o "$output_file"

    # 🔹 ADDED: DNS resolution
    cat "$output_file" | dnsx -silent -o "$resolved_file"

    echo "All results saved to: $output_file"
    echo "Resolved domains saved to: $resolved_file"
}

# Multiple domains mode
list_domain_mode() {
    read -p "Enter the path to the list of domains file: " domain_list
    read -p "Enter the project name: " project_name

    if [[ ! -f "$domain_list" ]]; then
        echo "File not found! Exiting."
        exit 1
    fi

    local targets_folder="Targets"
    local project_path="${targets_folder}/${project_name}"
    mkdir -p "$project_path"

    local output_file="${project_path}/subs.txt"
    local resolved_file="${project_path}/resolved.txt"

    while IFS= read -r domain; do
        [[ -z "$domain" ]] && continue
        echo "Processing $domain..."
        enumerate_domain "$domain" "$output_file"
    done < "$domain_list"

    echo "Deduplicating all results..."
    sort -u "$output_file" -o "$output_file"

    # 🔹 ADDED: DNS resolution
    cat "$output_file" | dnsx -silent -o "$resolved_file"

    echo "All subdomains saved to: $output_file"
    echo "Resolved domains saved to: $resolved_file"
}

# Main execution
print_colored_banner

echo "Select mode:"
echo "1) Scan a single domain"
echo "2) Scan a list of domains from file"
read -p "Enter your choice (1 or 2): " choice

case $choice in
    1)
        single_domain_mode
        ;;
    2)
        list_domain_mode
        ;;
    *)
        echo "Invalid option. Exiting."
        exit 1
        ;;
esac
