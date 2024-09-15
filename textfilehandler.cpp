#include "textfilehandler.h"

TextFileHandler::TextFileHandler(QObject *parent) : QObject(parent) {
}

// Сохранение в файл
void TextFileHandler::saveToFile(QString filePath, QString text) {
    QFile file(filePath);
    if (file.open(QIODevice::ReadWrite| QIODevice::Text | QIODevice::Truncate)) {
        QTextStream out(&file);
        out << text;
        file.close();
    }
}

// Загрузка из файла
QString TextFileHandler::loadFromFile(QString filePath) {
    QFile file(filePath);
    QString text;
    if (file.open(QIODevice::ReadOnly | QIODevice::Text)) {
        QTextStream in(&file);
        text = in.readAll();
        file.close();
    }
    return text;
}
