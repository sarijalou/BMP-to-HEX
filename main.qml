import QtQuick
import QtQuick.Window
import QtQuick.Controls 6.5
import QtQuick.Layouts
import QtQuick.Dialogs


ApplicationWindow
{
    property var mylist: []
    property int len_mylist
    width: Screen.width*2/3
    height: Screen.height/1.2
    visible: true
    title: qsTr("BMP to HEX")

    FileDialog
    {
        id: bmp_FileDialog_id
        //            currentFolder: StandardPaths.standardLocations(StandardPaths.PicturesLocation)[0]
        // onAccepted: image.source = selectedFile
        nameFilters: ["BMP file(*.bmp)"]
        onAccepted:
        {
            my_txt_id.text=selectedFile
            //group_edit_img_lbl_id.text=manager.copy_from_qml_png(selectedFile)
        }

    }
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
        id: bin_FileDialog_id

        //            currentFolder: StandardPaths.standardLocations(StandardPaths.PicturesLocation)[0]
        // onAccepted: image.source = selectedFile
        nameFilters: ["Bin Files (*.bin)"]
        fileMode:FileDialog.SaveFile
        onAccepted:
        {
            if (radio6.checked)
            {
                console.log("selectedFile66666666666666")
                manager.bmp_to_hex(my_txt_id.text,selectedFile)
            }
            //my_txt_id.text=selectedFile


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
    FileDialog
    {
        id: add_file_id
        //            currentFolder: StandardPaths.standardLocations(StandardPaths.PicturesLocation)[0]
        // onAccepted: image.source = selectedFile
        nameFilters: ["BIN file(*.bin)"]
        onAccepted:
        {
            mylist.push(selectedFile.toString())
            len_mylist=mylist.length
            console.log(mylist,mylist.length)
            //group_edit_img_lbl_id.text=manager.copy_from_qml_png(selectedFile)
        }
    }
    RowLayout
    {
        ColumnLayout
        {

            Text {
                id: my_txt_id
                text: qsTr("no file ")
            }
            Image{

                source: my_txt_id.text
                anchors.left: parent.left
            }
            Button
            {
                text: "choose"
                onClicked: bmp_FileDialog_id.open()
            }
            RadioButton
            {
                id:radio1
                checked: true
                text: qsTr("1 bit")
            }
            RadioButton
            {
                id:radio2
                text: qsTr("8 bit")
            }
            RadioButton
            {
                id:radio3
                text: qsTr("12 bit")
            }
            RadioButton
            {
                id:radio4
                text: qsTr("16 bit")
            }
            RadioButton
            {
                id:radio5
                text: qsTr("18 bit")
            }
            RadioButton
            {
                id:radio6

                text: qsTr("24 bit")
            }

            RowLayout
            {


                Button
                {
                    text: "Convert to hex"


                    onClicked:{

                        bin_FileDialog_id.open()}
                    //                onClicked: {
                    //                     bmp_FileDialog_id.open()
                    //                    manager.bmp_to_hex(my_txt_id.text,'output1.bin')
                    //                }
                }
                Button
                {
                    text: "Exit"
                    onClicked:close()
                }
            }

            Button
            {
                text: "add file to hex"
                onClicked:add_file_id.open()
            }
            Repeater
            {
            model:len_mylist

            Text {

                text:mylist[index]
                 }
            }
            Button
            {
                text: "save all "
                onClicked:
                {
                    console.log(mylist)
                    manager.combine_all('my_output.bin',mylist)

                        }
            }
            Button
            {
                text: "program"
                onClicked:close()
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
}
