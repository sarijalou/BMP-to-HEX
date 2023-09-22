# This Python file uses the following encoding: utf-8
import sys
from pathlib import Path
import wavetohex
import combine

from PySide6.QtGui import QGuiApplication
from PySide6.QtQml import QQmlApplicationEngine
from PySide6.QtCore import   QObject,Slot

from PySide6.QtCore import   QObject,Slot
from PySide6.QtGui import QGuiApplication 
from PySide6.QtQml import QQmlApplicationEngine
#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ata

class Manager(QObject):
    def __init__(self, parent=None):
        super().__init__(parent)
    @Slot(str,str)    
    def bmp_to_hex(self,bmp_file, hex_file):
        bmp_file=bmp_file[5:]
        print('salam')
        with open(bmp_file, 'rb') as bmp:
            # Read the BMP header (14 bytes)
            bmp_header = bmp.read(14)

            # Read the DIB header (40 bytes)
            dib_header = bmp.read(40)
            width = int.from_bytes(dib_header[4:8], 'little')
            height = int.from_bytes(dib_header[8:12], 'little')
            image_size = int.from_bytes(dib_header[20:24], 'little')
            bmp.seek(0, 0)

            # Skip the headers to get to the pixel data
            bmp.read(54)

            # Read the pixel data row by row and reverse each row
            pixel_data = []
            for _ in range(height):
                row_data = bmp.read(width * 3)
                pixel_data.insert(0, row_data)  # Insert each row at the beginning to reverse the order

        with open(hex_file[5:], 'wb+') as hex_output:
            # Write the width, height, and pixel data in hexadecimal format
            # hex_output.write(hex(width))
            # hex_output.write(bytes(height))
            # print(hex(width), type(width)) 

            # Write each pixel value in reversed order (B, G, R)
            for row in pixel_data:
                for i in range(0, len(row), 3):
                    b, g, r = row[i:i + 3]

                    hex_output.write(r.to_bytes(1))
                    hex_output.write(g.to_bytes(1))
                    hex_output.write(b.to_bytes(1))

        # Usage example
        bmp_file = 'ronaldo.bmp'
        hex_file = 'output1.bin'
        # bmp_to_hex(bmp_file, hex_file)
    @Slot(str,str)
    def wave_to_hex(self,wav_file, hex_file):
       wav_file=wav_file[5:]
       wavetohex.convert_wave_to_mono_8bit_hex(wav_file, hex_file)

    @Slot(str,list)
    def combine_all(self,combined_file, input_files):
        a=str(input_files[0])
        print(a,type(input_files))
        combine.combine_files(combined_file, input_files)

if __name__ == "__main__":
    app = QGuiApplication(sys.argv)
    engine = QQmlApplicationEngine()
    manager = Manager()
    engine.rootContext().setContextProperty("manager", manager)

   
   
    qml_file = Path(__file__).resolve().parent / "main.qml"
    engine.load(qml_file)
    if not engine.rootObjects():
        sys.exit(-1)
    sys.exit(app.exec())
