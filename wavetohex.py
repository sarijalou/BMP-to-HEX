import wave
import struct

def convert_wave_to_mono_8bit_hex(input_wave_file, output_hex_file):
    try:
        # Open the input wave file
        with wave.open(input_wave_file, 'rb') as wf:
            num_channels = wf.getnchannels()
            sample_width = wf.getsampwidth()
            frame_rate = wf.getframerate()
            frames = wf.readframes(-1)

            # Convert stereo to mono if needed
            if num_channels == 2:
                mono_frames = []
                for i in range(0, len(frames), 4):
                    left_sample, right_sample = struct.unpack('<hh', frames[i:i + 4])
                    mono_sample = (left_sample + right_sample) // 2
                    mono_frames.append(struct.pack('<h', mono_sample))
                frames = b''.join(mono_frames)
                num_channels = 1

            # Convert to 8-bit
            if sample_width == 2:
                frames = struct.unpack(f"<{len(frames)//2}h", frames)
                frames = [int((sample + 32768) / 256) for sample in frames]
                frames = struct.pack(f"<{len(frames)}B", *frames)
            else:
                print("error sample_width ")
            i=0
            # Write to hex file
            with open(output_hex_file, 'wb') as hex_file:
                for sample in frames:
                    i=i+1
                    if i%2==0:
                        hex_file.write(sample.to_bytes(1))
 
                # hex_data = ''.join([f'{sample:02X}' for sample in frames])
                # hex_file.write(hex_data)
                
        return True  # Conversion successful
    except Exception as e:
        print(f"An error occurred: {str(e)}")
        return False  # Conversion failed

## Example usage:
#input_wave_file = "audio.wav"
#output_hex_file = "ss.bin"
#if convert_wave_to_mono_8bit_hex(input_wave_file, output_hex_file):
#    print(f"Conversion from {input_wave_file} to {output_hex_file} successful.")
#else:
#    print(f"Conversion from {input_wave_file} to {output_hex_file} failed.")
