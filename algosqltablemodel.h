#ifndef ALGOSQLTABLEMODEL_H
#define ALGOSQLTABLEMODEL_H

#include <QObject>
#include <QSqlTableModel>
#include <QSqlDatabase>

class AlgoSqlTableModel : public QSqlTableModel
{
    Q_OBJECT
public:
    AlgoSqlTableModel(QObject* parent=0,QSqlDatabase db=QSqlDatabase());
    Q_INVOKABLE QVariant data(const QModelIndex &index, int role=Qt::DisplayRole ) const;
    Q_INVOKABLE bool setData(const QModelIndex &index,const QVariant &value,int role=Qt::EditRole);
    Q_INVOKABLE bool insertRow(int row,const QModelIndex &parent=QModelIndex());
    void generateRoleNames();
    QHash<int, QByteArray> roleNames() const {return roles; }
    Q_INVOKABLE void setSort(int column,Qt::SortOrder order);
    Q_INVOKABLE void setFilter(const QString& filter);
    Q_INVOKABLE bool submitAll();
    Q_INVOKABLE bool commit();
    Q_INVOKABLE bool removeRow(int row,const QModelIndex &parent=QModelIndex());
    Q_INVOKABLE  QVariantMap get( int rowNumber ) const  ;

private:
    QHash<int, QByteArray> roles;



};

#endif // ALGOSQLTABLEMODEL_H
