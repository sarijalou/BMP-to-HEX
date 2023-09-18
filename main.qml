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
        id: my_id
        //            currentFolder: StandardPaths.standardLocations(StandardPaths.PicturesLocation)[0]
        // onAccepted: image.source = selectedFile
        nameFilters: ["BMP file(*.BMP)"]
        onAccepted:
        {
            group_edit_img_lbl_id.text=manager.copy_from_qml_png(selectedFile)
        }
    }


    ColumnLayout
    {


        Button
        {
            text: "choose"
            onClicked: my_id.open()
        }
        RadioButton
        {
            checked: true
            text: qsTr("1 bit")
        }
        RadioButton
        {
            text: qsTr("8 bit")
        }
        RadioButton
        {
            text: qsTr("12 bit")
        }
        RadioButton
        {
            text: qsTr("16 bit")
        }
        RadioButton
        {
            text: qsTr("18 bit")
        }
        RadioButton
        {
            text: qsTr("24 bit")
        }

        RowLayout
        {
            Button
            {
                text: "Convert"
                onClicked:close()
            }
            Button
            {
                text: "Exit"
                onClicked: close()
            }
        }

        Button
        {
            text: "program"
            onClicked:close()
        }

    }
}
