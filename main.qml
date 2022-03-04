import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.3
import QtQuick.Dialogs 1.2
import ir.hcoding.modules 1.0
//import Qt.labs.platform 1.1

Window {
    id:app
    width: 640
    height: 480
    visible: true
    title: qsTr("Simple Editor")
    function getBaseLog(x, y) {
        return Math.log(y) / Math.log(x);
    }
    function openFile(fileUrl) {
        const mb = 14 * 1024 * 1024; //Unit: Bytes
//        if(fileSaver.getFileSize(fileUrl) > mb)
//        {
//            msg.text = "Limited open files (less than " + mb.toString() +" mb)!"
//            msg.open();
//            return;
//        }
        console.log("Here1");
        const myPromise = new Promise((resolve ) => {
                                          resolve();
                                      });
        return myPromise.then(()=>{
                           console.log("Here2");
                           var request = fileSaver.readFile(fileUrl,mb/4);
                           console.log("Here3");
                           mainTxt.text = request;
                       });
    }
    function saveFileUTF8(textToSave,completeFileName) {
        var blob = new Blob(textToSave, { type: "text/plain;charset=utf-8" });
        return saveAs(blob, completeFileName);
    }
    FileDialog {
        id:openFileDialog
        onAccepted:{
            try{
                openFile(openFileDialog.fileUrl);
            }
            catch(err){
                console.log("no response of Opening!")
            }
        }
    }

    MessageDialog{
        id:msg
        width: parent.width*0.6
        height: parent.height*0.6
        text: ""
    }

    FileSaver{
        id:fileSaver;
    }

    FileDialog {
        id:saveDialog
        selectExisting: true
        onAccepted:{
            var fileSelected = saveDialog.fileUrl;
            let savedByte = fileSaver.saveFile(mainTxt.text ,fileSelected);
            if(savedByte>0) {
                msg.text = "saved"}
            else{
                msg.text = "faild: " +  fileSaver.LAST_ERROR_STRING;
            }

            msg.open();
        }
    }
    Rectangle {
        anchors.fill:parent
        gradient: Gradient {
            GradientStop { position: 0; color: "#ffffff" }
            GradientStop { position: 1; color: "#c1bbf9" }
        }
    }
    ColumnLayout{
        anchors.fill: parent
        MenuBar{
            z:textEditorScrollView.z+1
            Layout.fillWidth: true
            Layout.maximumHeight: 50
            Menu {
                title: qsTr("File")
                //////////////////////////
                MenuItem{
                    text: qsTr("Open")
                    onTriggered: {
                        openFileDialog.open();
                    }
                }
                //////////////////////////
                MenuItem{
                    text: qsTr("save")
                    onTriggered: {
                        saveDialog.open();
                    }
                }
                //////////////////////////
                MenuSeparator{}
                //////////////////////////
                MenuItem{
                    text: qsTr("Exit")
                    onTriggered: {
                        Qt.callLater(Qt.quit)
                    }
                }
            }
        }
        ScrollView{
            id:textEditorScrollView
            Layout.fillWidth: true
            Layout.fillHeight: true
            TextEdit {
                id: mainTxt
                anchors.fill: parent
                font.pointSize: 16
                font.bold: true
                text: qsTr("")

                //                enabled: mainTxt.text == "" ? false : true;
            }
        }
    }
}
