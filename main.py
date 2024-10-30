import os
import subprocess

def print_colored_banner():
    # ANSI escape codes for yellow text and box border
    yellow = "\033[93m"
    reset = "\033[0m"
    box_border = yellow + "+" + "-" * 40 + "+"

    # Your ASCII art
    ascii_art = r"""
                                    ___   ___
     /\                            / _ \ / _ \
    /  \   _ __   ___  _ __  _   _| | | | (_) |
   / /\ \ | '_ \ / _ \| '_ \| | | | | | |> _ <
  / ____ \| | | | (_) | | | | |_| | |_| | (_) |
 /_/    \_\_| |_|\___/|_| |_|\__, |\___/ \___/
                              __/ |
                             |___/
    """

    # Print the banner in a colored box
    print(box_border)
    print(f"{yellow}|{' ' * 38}|")
    print(f"{yellow}|{ascii_art.center(38)}|")
    print(f"{yellow}|{' ' * 38}|")
    print(f"{yellow}|       Credits: Siddiq Ahmad   |")
    print(box_border)
    print(reset)

def create_project():
    # Ask the user for the domain and project name
    domain = input("Enter the domain: ")
    project_name = input("Enter the project name: ")

    # Define the target folder path
    targets_folder = "Targets"

# Create the project directory inside Targets
    project_path = os.path.join(targets_folder, project_name)
    os.makedirs(project_path, exist_ok=True)

    # Define the command to execute with placeholders replaced
    command = (
        f"sublist3r -d {domain} -o Targets/{project_name}/subs.txt && "
        f"subfinder -d {domain} -o Targets/{project_name}/subs.txt && "
        f"findomain -t {domain} -u Targets/{project_name}/subs.txt && "
        f"assetfinder -subs-only {domain} >> Targets/{project_name}/subs.txt && "
        f"sort Targets/{project_name}/subs.txt | uniq > Targets/{project_name}/temp.txt && "
        f"mv Targets/{project_name}/temp.txt Targets/{project_name}/subs.txt"
    )

    # Execute the command
    try:
        print(f"Executing command:\n{command}")
        subprocess.run(command, shell=True, check=True)
        print("Command executed successfully.")
    except subprocess.CalledProcessError as e:
        print(f"An error occurred while executing the command: {e}")

if __name__ == "__main__":
    print_colored_banner()  # Display the banner
    create_project()  # Call the create_project function
