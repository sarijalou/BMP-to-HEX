import QtQuick
import QtQuick.Controls.Material 6.5
import QtQuick.Layouts
import QtQuick.Dialogs


Item {
    property var mylist: []
    property var endAddrlist: []
    property int len_mylist
    property string mystr



    FileDialog
    {
        id: add_file_id
        //            currentFolder: StandardPaths.standardLocations(StandardPaths.PicturesLocation)[0]
        // onAccepted: image.source = selectedFile
        nameFilters: ["BIN file(*.bin)"]
        onAccepted:
        {
            mylist.push(selectedFile.toString())
            endAddrlist.push(manager.count_hex_bytes_in_file(selectedFile.toString()))
            len_mylist=mylist.length

            console.log(mylist,mylist.length,endAddrlist)
            //group_edit_img_lbl_id.text=manager.copy_from_qml_png(selectedFile)
        }
    }

    ColumnLayout
    {


        Button
        {
            text: "add file to hex"
            onClicked:add_file_id.open()
        }
        Repeater
        {
            model:len_mylist

            Text {
                text:endAddrlist[index] +"  "+ mylist[index]

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
}
