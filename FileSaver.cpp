#include "FileSaver.h"
#include <QDebug>
#include <QDir>
#include <QFile>
#include <QString>
#include <QUrl>
constexpr auto NO_ERROR = "No Error";
QString FileSaver::LAST_ERROR_STRING(NO_ERROR);
FileSaver::FileSaver(QObject* parent)
    : QObject{parent}
{ }

QString FileSaver::readFile(const QString& completeFileName, int maxSize)
{
    if(maxSize > MAX_SIZE_STRING_READ)
        maxSize = MAX_SIZE_STRING_READ;
    QString result;
    QUrl nativeAddress(completeFileName);
    QFile myFile(QDir::toNativeSeparators(nativeAddress.toLocalFile()));
    int readedSize = 0;
    if(myFile.open(QFile::ReadOnly))
    {
        while(!myFile.atEnd() && readedSize < maxSize)
        {
            auto readedLine = myFile.readLine();
            readedSize += readedLine.size();
            result.append(readedLine);
        }
        myFile.close();
    }
    return result;
}

int FileSaver::saveFile(const QString& text, const QString& completeFileName)
{
    int res = 0;
    QUrl nativeAddress(completeFileName);
    QFile myFile(QDir::toNativeSeparators(nativeAddress.toLocalFile()));
    if(myFile.open(QFile::OpenModeFlag::ReadWrite))
    {
        res = myFile.write(text.toLatin1());
        myFile.close();
        LAST_ERROR_STRING = NO_ERROR;
    }
    else
    {
        FileSaver::LAST_ERROR_STRING = myFile.errorString();
        qDebug() << "Error (cant open): " << LAST_ERROR_STRING << completeFileName;
    }
    return res;
}

int FileSaver::getFileSize(const QString& completeFileName)
{
    int res = -1;
    QUrl nativeAddress(completeFileName);
    QFile myFile(QDir::toNativeSeparators(nativeAddress.toLocalFile()));
    res = myFile.size();
    return res;
}

const QString& FileSaver::getLAST_ERROR_STRING()
{
    return LAST_ERROR_STRING;
}
