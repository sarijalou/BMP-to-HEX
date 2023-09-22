def combine_files(output_file, input_files):
    with open(output_file, 'wb') as output:
        for file in input_files:
            with open(file[5:], 'rb') as input:
                output.write(input.read())

# Usage example
#input_files = ['fafa.bin', 'sala.bin', 'output1.bin']
#output_file = 'combined.bin'

#combine_files(output_file, *input_files)
