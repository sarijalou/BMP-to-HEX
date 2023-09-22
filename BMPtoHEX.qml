import QtQuick
import QtQuick.Controls.Material 6.5
import QtQuick.Layouts
import QtQuick.Dialogs


Item
{

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
        RowLayout
        {
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
    }

}
