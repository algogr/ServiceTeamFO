#ifndef ALGOSQLQUERYMODEL_H
#define ALGOSQLQUERYMODEL_H

#include <QSqlQueryModel>
#include <QSqlQuery>
#include <QSqlDatabase>

#if defined(ALGOMODELCLASSES_LIBRARY)
#  define AlgoSqlQueryModel_EXPORT Q_DECL_EXPORT
#else
#  define AlgoSqlQueryModel_EXPORT Q_DECL_IMPORT
#endif



class AlgoSqlQueryModel : public QSqlQueryModel
{
    Q_OBJECT
public:
    AlgoSqlQueryModel(QSqlDatabase* db,const QString &querystr,QObject* parent=0);
    Q_INVOKABLE void setQuery();

    Q_INVOKABLE void refresh();
    Q_INVOKABLE bool setHeaderData(int section,Qt::Orientation orientation,const QVariant &value,int role =Qt::EditRole);
    Q_INVOKABLE  QVariantMap get( int rowNumber ) const  ;
    QHash<int, QByteArray> roleNames() const {return roles; }
    void generateRoleNames();
    QVariant data(const QModelIndex &index, int role) const;

private:
    QHash<int, QByteArray> roles;
    QSqlDatabase* m_db;
    QString m_querystr;
};

#endif // ALGOSQLQUERYMODEL_H
