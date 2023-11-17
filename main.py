import wavetohex
import combine
import bmphex
import flash

import sys
from pathlib import Path


from PySide6.QtGui import QGuiApplication
from PySide6.QtQml import QQmlApplicationEngine
from PySide6.QtCore import   QObject,Slot

#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ata

class Manager(QObject):
    def __init__(self, parent=None):
        super().__init__(parent)
        
    @Slot(str,str)    
    def bmp_to_hex(self,bmp_file, hex_file):
        bmphex.bmptohex(bmp_file,hex_file)

    @Slot(str,str)
    def wave_to_hex(self,wav_file, hex_file):
       wav_file=wav_file[5:]
       wavetohex.convert_wave_to_mono_8bit_hex(wav_file, hex_file)

    @Slot(str,list)
    def combine_all(self,combined_file, input_files):
        a=str(input_files[0])
        print(a,type(input_files))
        combine.combine_files(combined_file, input_files)

    @Slot(str,result=int)
    def count_hex_bytes_in_file(self,file_path):
        with open(file_path[5:], 'rb') as file:
            # Read the entire content of the file into a bytes object
            binary_data = file.read()
            return len(binary_data)

    @Slot(str,str,int)
    def fill_EndOfFile_with_ff_main(self,input_file,output_file,size):
        combine.fill_EndOfFile_with_ff(input_file,output_file,size)

if __name__ == "__main__":
    app = QGuiApplication(sys.argv)
    engine = QQmlApplicationEngine()
    manager = Manager()
    programmer=flash.Programmer()
    engine.rootContext().setContextProperty("manager", manager)
    engine.rootContext().setContextProperty("programmer", programmer)

   
   
    qml_file = Path(__file__).resolve().parent / "qmls/main.qml"
    engine.load(qml_file)
    if not engine.rootObjects():
        sys.exit(-1)
    sys.exit(app.exec())
