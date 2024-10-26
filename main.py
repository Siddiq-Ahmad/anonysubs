import os
import subprocess
import sys
import re

def create_directory(project_name):
    """Create a directory for the project inside the Targets folder."""
    target_dir = os.path.join("Targets", project_name)
    try:
        os.makedirs(target_dir, exist_ok=True)
        return target_dir
    except Exception as e:
        print(f"Error creating directory: {e}")
        sys.exit(1)

def subdomain_scan(domain, project_dir):
    """Scan for subdomains using various tools and save results in Subs.txt."""
    subs_file = os.path.join(project_dir, "Subs.txt")
    try:
        with open(subs_file, 'w') as f:
            # Sublist3r
            subprocess.run(['sublist3r', '-d', domain, '-o', subs_file])
            
            # Subfinder
            subprocess.run(['subfinder', '-d', domain, '-o', subs_file, '-silent'])
            
            # Assetfinder
            subprocess.run(['assetfinder', '--subs-only', domain], stdout=f)
            
            # crt.sh
            crt_sh_command = f"curl -s https://crt.sh/?q={domain}&output=json | jq -r '.[].name_value' | grep -Po '(\w+\.\w+\.\w+)$'"
            subprocess.run(crt_sh_command, shell=True, stdout=f)
        
        # Remove duplicate entries
        unique_subs = set()
        with open(subs_file, 'r') as f:
            for line in f:
                unique_subs.add(line.strip())
        
        with open(subs_file, 'w') as f:
            f.write("\n".join(unique_subs))
        
        print(f"Subdomain scan completed. Unique subdomains saved in {subs_file}")
    except Exception as e:
        print(f"Error during subdomain scan: {e}")

def live_subdomain_filter(project_dir):
    """Filter live subdomains using httpx-toolkit and save results in live-Subs.txt."""
    subs_file = os.path.join(project_dir, "Subs.txt")
    live_subs_file = os.path.join(project_dir, "live-Subs.txt")
    
    try:
        if not os.path.exists(subs_file):
            print(f"{subs_file} does not exist. Please run the subdomain scan first.")
            return
        
        with open(live_subs_file, 'w') as live_file:
            subprocess.run(['httpx', '-l', subs_file, '-silent', '-o', live_subs_file])
        
        print(f"Live subdomains saved in {live_subs_file}")
    except Exception as e:
        print(f"Error during live subdomain filtering: {e}")

def display_logo():
    """Display the ASCII logo at the start of the tool."""
    logo = """
                                    ___   ___  
     /\                            / _ \ / _ \ 
    /  \   _ __   ___  _ __  _   _| | | | (_) |
   / /\ \ | '_ \ / _ \| '_ \| | | | | | |> _ < 
  / ____ \| | | | (_) | | | | |_| | |_| | (_) |
 /_/    \_\_| |_|\___/|_| |_|\__, |\___/ \___/ 
                              __/ |            
                             |___/             
    """
    print(f"\033[91m{logo}\033[0m")  # Display in red

def main():
    """Main function to run the subdomain scanning tool."""
    display_logo()
    
    # Get user input
    domain = input("Enter the domain name (e.g., example.com): ").strip()
    project_name = input("Enter the project name: ").strip()
    
    # Create project directory
    project_dir = create_directory(project_name)
    
    # Perform subdomain scanning
    subdomain_scan(domain, project_dir)
    
    # Filter live subdomains
    live_subdomain_filter(project_dir)

if __name__ == "__main__":
    main()
