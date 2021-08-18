import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.3
import QtQuick.Dialogs 1.2
Window {
    id:app
    width: 640
    height: 480
    visible: true
    title: qsTr("Simple Editor")
    function openFile(fileUrl) {
        var request = new XMLHttpRequest();
        request.open("GET", fileUrl, false);
        request.send(null);
        return request.responseText;
    }
    FileDialog {
        id:fileDialog
        onAccepted:{
            var resp = openFile(fileDialog.fileUrl);
            mainTxt.text = resp;
        }
    }

    ColumnLayout
    {
        anchors.fill: parent
        MenuBar
        {
            Layout.fillWidth: true
            height: 50;
            Menu
            {
                title: qsTr("File")
                //////////////////////////
                Action{
                    text: qsTr("Open")
                    onTriggered: {
                        fileDialog.open();
                    }
                }
                //////////////////////////
                Action{
                    text: qsTr("save - isComing")
                    onTriggered: {
                    }
                }
                //////////////////////////
                MenuSeparator{}
                //////////////////////////
                Action{
                    text: qsTr("Exit")
                    onTriggered: {
                        Qt.callLater(Qt.quit)
                    }
                }
            }
        }
        TextEdit {
            Layout.fillWidth: true
            Layout.fillHeight: true
            id: mainTxt
            text: qsTr("")
            enabled: mainTxt.text == "" ? false : true;
        }
    }
}
