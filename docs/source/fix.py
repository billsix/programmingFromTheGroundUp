import re
import argparse
import sys
import os
 
def find_duplicate_backtick_strings(text):
    """
    Finds all instances of a repeated substring within backticks.
 
    Args:
        text (str): The input string to search.
 
    Returns:
        list: A list of tuples, where each tuple contains:
              - The full matched string (e.g., ``runrun``)
              - The repeated content (e.g., run)
              - The starting position of the match.
    """
    # This regex pattern finds ``substring_substring``
    pattern = r"``([^`]+)\1``"
   
    matches = []
    # Using re.finditer to find all non-overlapping matches
    for match in re.finditer(pattern, text):
        match_info = (
            match.group(0),
            match.group(1),
            match.start()
        )
        matches.append(match_info)
       
    return matches
 
def main():
    """
    Main function to parse command-line arguments and run the search.
    """
    # Set up argument parser
    parser = argparse.ArgumentParser(
        description="Finds duplicated strings within backticks from a file."
    )
    parser.add_argument(
        "file_path",
        help="Path to the input file to be analyzed."
    )
 
    args = parser.parse_args()
    file_path = args.file_path
 
    # Check if the file exists
    if not os.path.isfile(file_path):
        print(f"Error: The file '{file_path}' does not exist.", file=sys.stderr)
        sys.exit(1)
 
    try:
        # Open and read the entire file content
        with open(file_path, 'r', encoding='utf-8') as f:
            file_content = f.read()
    except IOError as e:
        print(f"Error reading file '{file_path}': {e}", file=sys.stderr)
        sys.exit(1)
 
    # Perform the search
    duplicate_matches = find_duplicate_backtick_strings(file_content)
 
    # Print the results
    if duplicate_matches:
        print(f"Found repeated strings within backticks in '{file_path}':")
        for full_match, repeated_content, start_index in duplicate_matches:
            # For multiline files, showing the line number is more helpful.
            # Find the line number by counting newlines before the match.
            line_number = file_content.count('\n', 0, start_index) + 1
            print(f"  - At line {line_number}, index {start_index}:")
            print(f"    - Full Match: '{full_match}'")
            print(f"    - Repeated Content: '{repeated_content}'")
    else:
        print(f"No repeated strings within backticks were found in '{file_path}'.")
 
if __name__ == "__main__":
    main()
