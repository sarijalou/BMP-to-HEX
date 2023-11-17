from PIL import Image

def bmptohex(file_path, output_path):
    file_path=file_path[5:]
    output_path=output_path[5:]
    try:
        with Image.open(file_path) as img:
            # Convert the image to RGB mode
            img = img.convert("RGB")

            with open(output_path, 'wb') as output_file:
                width, height = img.size

                output_file.write(width.to_bytes(2, byteorder='little'))
                output_file.write(height.to_bytes(2, byteorder='little'))

                for y in range(height):
                    for x in range(width):
                        r, g, b = img.getpixel((x, y))

                        # Convert RGB to 24-bit hex representation (little-endian)
                        rgb_hex = (b << 16) | (g << 8) | r
                        output_file.write(rgb_hex.to_bytes(3, byteorder='little'))

        print(f"RGB values saved as a 24-bit binary file: {output_path}")
    except FileNotFoundError:
        print("File not found!")
    except Exception as e:
        print("Error:", e)
