import QtQuick
import QtQuick.Window
import QtQuick.Controls.Material
import QtQuick.Layouts
import QtQuick.Dialogs


ApplicationWindow
{
    width: Screen.width*2/3
    height: Screen.height/1.2
    visible: true
    title: qsTr("BMP to HEX")

    Material.accent: Material.Green
    Material.theme: Material.Dark

    TabBar
    {
        id: bar
        width: parent.width
        TabButton
        {
            text: qsTr("BMP to HEX")
        }
        TabButton
        {
            text: qsTr("WAVE to HEX")
        }
        TabButton
        {
            text: qsTr("COMBINE HEX FILES")
        }
    }

    StackLayout {
        y:bar.height+1

        width: parent.width
        height: parent.height-y
        currentIndex: bar.currentIndex
        BMPtoHEX{}
        WAVEtoHEX{}
        COMBINE{}
    }




    /*







    */
}
