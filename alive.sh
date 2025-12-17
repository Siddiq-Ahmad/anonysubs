#!/bin/bash

yellow="\033[93m"
reset="\033[0m"

print_colored_banner() {
    echo -e "${yellow}+----------------------------------------+"
    echo -e "${yellow}|       Credits: Siddiq Ahmad            |"
    echo -e "${yellow}+----------------------------------------+"
cat <<'EOF'
  /$$$$$$            /$$             /$$$$$$$$
 /$$__  $$          | $$            |__  $$__/
| $$  \__/ /$$   /$$| $$$$$$$          | $$  /$$$$$$  /$$$$$$   /$$$$$$$  /$$$$$$
|  $$$$$$ | $$  | $$| $$__  $$         | $$ /$$__  $$|____  $$ /$$_____/ /$$__  $$
 \____  $$| $$  | $$| $$  \ $$         | $$| $$  \__/ /$$$$$$$| $$      | $$$$$$$$
 /$$  \ $$| $$  | $$| $$  | $$         | $$| $$      /$$__  $$| $$      | $$_____/
|  $$$$$$/|  $$$$$$/| $$$$$$$/         | $$| $$     |  $$$$$$$|  $$$$$$$|  $$$$$$$
 \______/  \______/ |_______/          |__/|__/      \_______/ \_______/ \_______/



EOF
    echo -e "${yellow}+----------------------------------------+${reset}"
}

main() {
    print_colored_banner

    read -p "Enter project name: " project_name

    project_dir="Targets/${project_name}"
    input_file="${project_dir}/subs.txt"
    unfiltered="${project_dir}/httpx-full.txt"
    alive="${project_dir}/alive.txt"

    mkdir -p "$project_dir"

    if [[ ! -f "$input_file" ]]; then
        echo -e "${yellow}Input file not found: $input_file${reset}"
        exit 1
    fi

    echo -e "${yellow}Running httpx...${reset}"

    # ===== CLEAN, RELIABLE, NOTHING MISSED =====
    cat "$input_file" | httpx \
        -follow-redirects \
        -random-agent \
        -probe-all-ips \
        -timeout 10 \
        -threads 200 \
        -status-code \
        -title \
        -tech-detect \
        -mc 200,403 \
        -ports 80,443,8080,8000,8443 \
        | tee "$unfiltered"

    echo -e "${yellow}Extracting clean URLs...${reset}"

    # Only take first column
    awk '{print $1}' "$unfiltered" > "$alive.tmp"

    # Prefer HTTPS over HTTP
    awk -F/ '
    {
        scheme=$1
        sub(/:$/, "", scheme)
        domain=$3
        if (seen[domain] == "https") next
        if (scheme == "https") seen[domain] = "https"
        else if (!seen[domain]) seen[domain] = "http"
        urls[domain] = scheme "://" domain
    }
    END { for (d in urls) print urls[d] }
    ' "$alive.tmp" > "$alive"

    rm "$alive.tmp"

    echo -e "${yellow}Done.$reset"
    echo -e "${yellow}Full:   $unfiltered${reset}"
    echo -e "${yellow}Alive:  $alive${reset}"
}

main
