# Define the path to the original file and the output file
input_file_path = '/Users/stephen/Mirror/BMI_776/project/Autism/liftover_errors.txt'
output_file_path = 'liftover_errors_clean.txt'

# Open the original file in read mode and the output file in write mode
with open(input_file_path, 'r') as infile, open(output_file_path, 'w') as outfile:
    # Iterate through each line in the original file
    for line in infile:
        # Check if the line does not start with '#'
        if not line.strip().startswith('#'):
            # Write the line to the output file if it does not start with '#'
            outfile.write(line)
