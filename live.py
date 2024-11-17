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

def main():
    # ANSI escape codes for yellow text
    yellow = "\033[93m"
    reset = "\033[0m"

    print_colored_banner()

    # Ask for the project name
    project_name = input("Enter the exact project name: ")

    # Define the command to run
    command = f"cat Targets/{project_name}/subs.txt | httpx-toolkit -ports 80,443,8080,8000,8888 -threads 200 -mc 200,403 -title -tech-detect > Targets

    try:
        # Execute the command
        subprocess.run(command, shell=True, check=True)
        print(f"{yellow}Successfully filtered live domains for project '{project_name}' and saved to Targets/{project_n>    except subprocess.CalledProcessError as e:
        print(f"{yellow}An error occurred: {e}{reset}")

if __name__ == "__main__":
    main()
