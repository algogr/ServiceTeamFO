#include "variousexposed.h"
#include <QSettings>
#include <QFile>
#include <QCoreApplication>
VariousExposed::VariousExposed(QObject *parent) : QObject(parent)
{

}

QString VariousExposed::readSetting(const QString &setting)
{
    QFile st(QCoreApplication::applicationDirPath()+"/settings.ini");
    QString settingsFile=QCoreApplication::applicationDirPath() +"/settings.ini";
    QSettings settings(settingsFile,QSettings::IniFormat);

    st.open(QIODevice::ReadOnly);
    QString settingValue=settings.value(setting).toString();
    st.close();
    return settingValue;


}

void VariousExposed::writeSetting(const QString &setting,const QString &settingValue)
{
    QFile st(QCoreApplication::applicationDirPath()+"/settings.ini");
    QString settingsFile=QCoreApplication::applicationDirPath() +"/settings.ini";
    QSettings settings(settingsFile,QSettings::IniFormat);

    st.open(QIODevice::ReadWrite);
    settings.setValue(setting,settingValue);

    st.close();
    return ;

}
