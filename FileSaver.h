#ifndef FILESAVER_H
#define FILESAVER_H

#include <QObject>
class FileSaver : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString LAST_ERROR_STRING READ getLAST_ERROR_STRING CONSTANT)

public:
    explicit FileSaver(QObject* parent = nullptr);

    Q_INVOKABLE static QString readFile(const QString& completeFileName, int maxSize);
    Q_INVOKABLE static int saveFile(const QString& text, const QString& completeFileName);
    Q_INVOKABLE static int getFileSize(const QString& completeFileName);
    static QString LAST_ERROR_STRING;
    static const int MAX_SIZE_STRING_READ = 2 * 1024 * 1024;
    static const QString& getLAST_ERROR_STRING();

signals:
};

#endif // FILESAVER_H
