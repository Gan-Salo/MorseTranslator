#ifndef TEXTFILEHANDLER_H
#define TEXTFILEHANDLER_H

#include <QObject>
#include <QString>
#include <QFile>
#include <QTextStream>

class TextFileHandler : public QObject
{
    Q_OBJECT

public:
    explicit TextFileHandler(QObject *parent = nullptr);

public slots:
    void saveToFile(QString filePath, QString text);   // Сохранение в файл
    QString loadFromFile(QString filePath);     // Загрузка из файла
};

#endif // TEXTFILEHANDLER_H
