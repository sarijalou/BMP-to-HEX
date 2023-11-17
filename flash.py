from PySide6.QtCore import   QObject,Slot

import subprocess



class Programmer(QObject):
    def __init__(self, parent=None):
        super().__init__(parent)

    @Slot(str,str)
    def run_flashrom_command(self,chip_type='W25Q32.V', firmware_file='my_output2.bin'):
        command = f"flashrom -V -p ch341a_spi -c {chip_type} -w {firmware_file}"
        process = subprocess.Popen(command, stdout=subprocess.PIPE, stderr=subprocess.STDOUT, text=True, shell=True)

        while True:
            output = process.stdout.readline()
            if output == '' and process.poll() is not None:
                break
            if output:
                print(output.strip())

            print( process.returncode)
        print("done!!!! done!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!")

    @Slot(str,str)
    def write_flashrom(self,chip_type, firmware_file):
        command = ["flashrom","-V", "-p", "ch341a_spi", "-c", chip_type, "-w", firmware_file]

        try:
#            a=subprocess.run(command, check=True,capture_output=True)
            a=subprocess.run(command,capture_output=True)
            print("\n\n\n",a,"\n\n\n")
#            print("Flashrom command executed successfully.")
        except subprocess.CalledProcessError as e:
            print(f"Error executing flashrom command: {e}")



if __name__ == "__main__":
    pass
