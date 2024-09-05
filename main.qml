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

        fileMode: FileDialog.SaveFile
        nameFilters: ["Text files (*.txt)"]
        onAccepted: {
            var filePath = fileDialogSave.selectedFile.toString();
            filePath = filePath.replace("file:///", "");
            fileHandler.saveToFile(filePath, outputText.text);
        }
    }

    FileDialog {
        id: fileDialogLoad

        fileMode: FileDialog.OpenFile
        nameFilters: ["Text files (*.txt)"]
        onAccepted: {
            var filePath = fileDialogLoad.selectedFile.toString();
            filePath = filePath.replace("file:///", "");
            var fileContent = fileHandler.loadFromFile(filePath);
            inputText.text = fileContent;
            updateTranslation();
        }
    }

    function updateTranslation() {
        if (languageSelector.currentIndex === 0) {
            outputText.text = translator.textToMorse(inputText.text);
        }
        else {
            outputText.text = translator.morseToText(inputText.text);
        }
    }

    Column {
        anchors.fill: parent
        anchors.margins: 20
        spacing: 20

        ComboBox {
            id: languageSelector
            model: ["Английский -> Морзе", "Морзе -> Английский"]
            width: parent.width * 0.5
            font.pointSize: 14
            onCurrentIndexChanged: {
                updateTranslation();
            }
        }

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
