import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Dialogs
import TranslatorLogic 1.0
import FileHandler 1.0

ApplicationWindow {
    visible: true
    width: 800
    height: 350
    title: "Morse Translator"

    TranslatorLogic {
        id: translator
    }

    TextFileHandler {
        id: fileHandler
    }

    FileDialog {
        id: fileDialogSave
        title: "Save File"
        nameFilters: ["Text files (*.txt)"]
        fileMode: FileDialog.SaveFile

        onAccepted: {
            var filePath = fileDialogSave.selectedFile.toString();
            filePath = filePath.replace(Qt.platform.os === "windows" ? "file:///" : "file://", "");
            fileHandler.saveToFile(filePath, outputText.text);
        }
    }

    FileDialog {
        id: fileDialogLoad
        title: "Open File"
        nameFilters: ["Text files (*.txt)"]
        fileMode: FileDialog.OpenFile

        onAccepted: {
            var filePath = fileDialogLoad.selectedFile.toString();
            filePath = filePath.replace(Qt.platform.os === "windows" ? "file:///" : "file://", "");
            var fileContent = fileHandler.loadFromFile(filePath);
            inputText.text = fileContent;
            updateTranslation();
        }
    }

    function updateTranslation() {
        if (translator.isMorse(inputText.text)) {
            outputText.text = translator.morseToText(inputText.text);
        } else {
            outputText.text = translator.textToMorse(inputText.text);
        }
    }

    Column {
        anchors.fill: parent
        anchors.margins: 20
        spacing: 20

        Row {
            spacing: 20
            width: parent.width

            ScrollView {
                width: parent.width * 0.5
                height: 200

                TextArea {
                    id: inputText

                    height: 200
                    selectByMouse: true
                    placeholderText: ""
                    wrapMode: TextEdit.Wrap
                    font.pointSize: 14

                    onTextChanged: {
                        updateTranslation();
                    }
                }
            }

            ScrollView {
                width: parent.width * 0.5
                height: 200


                TextArea {
                    id: outputText

                    selectByMouse: true
                    readOnly: true
                    font.pointSize: 14
                    placeholderText: "Перевод"
                    wrapMode: TextEdit.Wrap
                    focus: true
                }
            }
        }

        Row {
            spacing: 10
            width: parent.width
            anchors.horizontalCenter: parent.horizontalCenter

            Button {
                text: "Очистить"
                width: parent.width * 0.3
                font.pointSize: 14

                onClicked: {
                    inputText.text = "";
                    outputText.text = "";
                }
            }

            Button {
                text: "Загрузить из файла"
                width: parent.width * 0.3
                font.pointSize: 14

                onClicked: {
                    fileDialogLoad.open()
                }
            }

            Button {
                text: "Сохранить в файл"
                width: parent.width * 0.3
                font.pointSize: 14

                onClicked: {
                    fileDialogSave.open()
                }
            }
        }
    }
}
