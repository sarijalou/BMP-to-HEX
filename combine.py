def combine_files(output_file, input_files):
    with open(output_file, 'wb') as output:

        addrs=len(input_files)*4

        for file in input_files:
            with open(file[5:], 'rb') as input:
                addrs+=len(input.read())
                output.write(addrs.to_bytes(4, byteorder='little'))

        for file in input_files:
            with open(file[5:], 'rb') as input:
                output.write(input.read())


def fill_EndOfFile_with_ff(file_path, output_path,size_Mb):
    # Define the target size in bits (32 Mbits)
    target_size_bits = size_Mb * 1024 * 1024

    # Open the input file in binary mode
    with open(file_path, 'rb') as input_file:
        # Read the content of the input file
        data = input_file.read()

        # Calculate the current size in bits
        current_size_bits = len(data) * 8

        # Calculate the number of 0xFF bytes needed to reach the target size
        remaining_bits = target_size_bits - current_size_bits
        remaining_bytes = remaining_bits // 8
        padding = b'\xFF' * remaining_bytes
        
        print("target_size_bits",target_size_bits)
        print("current_size_bits",current_size_bits)
        print("remaining_bits",remaining_bits)
        

        # Combine the original data with the padding
        completed_data = data + padding

    # Write the completed data to the output file
    with open(output_path, 'wb') as output_file:
        output_file.write(completed_data)

    print("fill_EndOfFile_with_ff_finished")


if __name__ == "__main__":
    # Example usage:
    input_file_path = 'my_output.bin'
    output_file_path = 'my_output2.bin'
    fill_EndOfFile_with_ff(input_file_path, output_file_path,32)



        
            

