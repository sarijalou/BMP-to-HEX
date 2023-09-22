import QtQuick
import QtQuick.Controls.Material 6.5
import QtQuick.Layouts
import QtQuick.Dialogs

Item {

    FileDialog
    {
        id: wav_FileDialog_id
        //            currentFolder: StandardPaths.standardLocations(StandardPaths.PicturesLocation)[0]
        // onAccepted: image.source = selectedFile
        nameFilters: ["wave file(*.wav)"]
        onAccepted:
        {
            audio_text_id.text=selectedFile
            //group_edit_img_lbl_id.text=manager.copy_from_qml_png(selectedFile)
        }

    }

    FileDialog
    {
        id: wav_bin_FileDialog_id

        //            currentFolder: StandardPaths.standardLocations(StandardPaths.PicturesLocation)[0]
        // onAccepted: image.source = selectedFile
        nameFilters: ["Bin Files (*.bin)"]
        fileMode:FileDialog.SaveFile
        onAccepted:
        {
            if (radio_wav_8bit.checked)
            {
                console.log("selectedFile6seshan")
                manager.wave_to_hex(audio_text_id.text,selectedFile)
            }
            //my_txt_id.text=selectedFile


        }
    }
    ColumnLayout
    {
        Text {
            id: audio_text_id
            text: qsTr("no audio")
        }
        Button
        {
            text: 'choose wave file'
            onClicked: wav_FileDialog_id.open()
        }
        RadioButton
        {
            id:radio_wav_8bit
            checked: true
            text: qsTr("8 bit")
        }
        RadioButton
        {
            id:radio_wav_16bit
            text: qsTr("16 bit")
        }
        RadioButton
        {
            id:radio_wav_32bit
            text: qsTr("32 bit")
        }
        Button
        {
            text: 'wave to hex'
            onClicked: wav_bin_FileDialog_id.open()
        }


    }
}
