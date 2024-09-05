#include "translatorlogic.h"

TranslatorLogic::TranslatorLogic(QObject *parent) : QObject(parent) {

    morseToEnglishChar = {
        {".-", 'A'}, {"-...", 'B'}, {"-.-.", 'C'}, {"-..", 'D'}, {".", 'E'}, {"..-.", 'F'},
        {"--.", 'G'}, {"....", 'H'}, {"..", 'I'}, {".---", 'J'}, {"-.-", 'K'}, {".-..", 'L'},
        {"--", 'M'}, {"-.", 'N'}, {"---", 'O'}, {".--.", 'P'}, {"--.-", 'Q'}, {".-.", 'R'},
        {"...", 'S'}, {"-", 'T'}, {"..-", 'U'}, {"...-", 'V'}, {".--", 'W'}, {"-..-", 'X'},
        {"-.--", 'Y'}, {"--..", 'Z'}, {"-----", '0'}, {".----", '1'}, {"..---", '2'},
        {"...--", '3'}, {"....-", '4'}, {".....", '5'}, {"-....", '6'}, {"--...", '7'},
        {"---..", '8'}, {"----.", '9'}
    };

    englishCharToMorse = {
        {'A', ".-"}, {'B', "-..."}, {'C', "-.-."}, {'D', "-.."}, {'E', "."}, {'F', "..-."},
        {'G', "--."}, {'H', "...."}, {'I', ".."}, {'J', ".---"}, {'K', "-.-"}, {'L', ".-.."},
        {'M', "--"}, {'N', "-."}, {'O', "---"}, {'P', ".--."}, {'Q', "--.-"}, {'R', ".-."},
        {'S', "..."}, {'T', "-"}, {'U', "..-"}, {'V', "...-"}, {'W', ".--"}, {'X', "-..-"},
        {'Y', "-.--"}, {'Z', "--.."}, {'0', "-----"}, {'1', ".----"}, {'2', "..---"},
        {'3', "...--"}, {'4', "....-"}, {'5', "....."}, {'6', "-...."}, {'7', "--..."},
        {'8', "---.."}, {'9', "----."}
    };
}

// Перевод английского текста в символы Морзе
QString TranslatorLogic::textToMorse(QString text) {
    QString morse;
    for (QChar ch : text.toUpper()) {
        if (englishCharToMorse.contains(ch)) {
            morse += englishCharToMorse[ch] + " ";
        } else if (ch == ' ') {
            morse += " ";
        }
    }
    return morse;
}

// Перевод символов Морзе в английский текст
QString TranslatorLogic::morseToText(QString morse) {
    QString text;
    QStringList words = morse.split("  ");  // Разделение слов
    for (QString word : words) {
        QStringList chars = word.split(' ');    // Разделение символов
        for (QString ch : chars) {
            if (morseToEnglishChar.contains(ch)) {
                text += morseToEnglishChar[ch];
            }
        }
        text += ' ';
    }
    return text;
}

// Проверка, является ли символ подходящим для азбуки Морзе
bool TranslatorLogic::isMorse(QString input) {
    for (QChar ch : input) {
        if (ch != '.' && ch != '-' && ch != ' ') {
            return false;
        }
    }
    return true;
}
