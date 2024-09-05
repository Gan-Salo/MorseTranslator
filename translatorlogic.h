#ifndef TRANSLATORLOGIC_H
#define TRANSLATORLOGIC_H

#include <QObject>
#include <QString>
#include <QHash>

class TranslatorLogic : public QObject
{
    Q_OBJECT

public:
    explicit TranslatorLogic(QObject *parent = nullptr);

public slots:
    QString textToMorse(QString text);   // Перевод английского текста в символы Морзе
    QString morseToText(QString morse);  // Перевод символов Морзе в английский текст
    bool isMorse(QString input);         // Проверка, является ли символ подходящим для азбуки Морзе

private:
    QHash<QString, QChar> morseToEnglishChar;   // Таблица для перевода символов Морзе в английский текст
    QHash<QChar, QString> englishCharToMorse;   // Таблица для перевода английского текста в символы Морзе
};

#endif // TRANSLATORLOGIC_H



