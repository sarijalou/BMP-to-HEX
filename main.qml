import QtQuick
import QtQuick.Window
import QtQuick.Controls 6.5
import QtQuick.Layouts
import QtQuick.Dialogs


ApplicationWindow
{
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
            }
            my_txt_id.text=selectedFile
            manager.bmp_to_hex(my_txt_id.text,selectedFile)

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
            anchors.right:parent.right
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
            onClicked:close()
        }
        Button
        {
            text: "save all "
            onClicked:close()
        }
        Button
        {
            text: "program"
            onClicked:close()
        }

    }


}
