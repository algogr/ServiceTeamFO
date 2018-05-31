#ifndef VARIOUSEXPOSED_H
#define VARIOUSEXPOSED_H

#include <QObject>

class VariousExposed : public QObject
{
    Q_OBJECT
public:
    explicit VariousExposed(QObject *parent = nullptr);
    Q_INVOKABLE QString readSetting(const QString& setting);
    Q_INVOKABLE void writeSetting(const QString &setting,const QString &settingValue);

signals:

public slots:
};

#endif // VARIOUSEXPOSED_H
