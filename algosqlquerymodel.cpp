#include "algosqlquerymodel.h"
#include <QDebug>
#include <QSqlError>

AlgoSqlQueryModel::AlgoSqlQueryModel(QSqlDatabase* db,const QString &querystr,QObject* parent):QSqlQueryModel(parent),m_db(db),m_querystr(querystr)
{


}

void AlgoSqlQueryModel::setQuery()
{
    QSqlQueryModel::setQuery(m_querystr,*m_db);
}


void AlgoSqlQueryModel::refresh()
{


    if(!m_db->open())
    {

        m_db->open();

    }

    setQuery();




}

bool AlgoSqlQueryModel::setHeaderData(int section, Qt::Orientation orientation, const QVariant &value, int role)
{
    QSqlQueryModel::setHeaderData(section,orientation,value,role);

}

void AlgoSqlQueryModel::generateRoleNames()
{
    roles.clear();

        int nbCols = this->columnCount();

        for (int i = 0; i < nbCols; i++)
        {
            roles[Qt::UserRole + i + 1] = QVariant(this->headerData(i, Qt::Horizontal).toString()).toByteArray();
        }

}

QVariant AlgoSqlQueryModel::data(const QModelIndex &index, int role) const
{
    if(index.row() >= rowCount())
        {
            return QString("");
        }
        if(role < Qt::UserRole)
        {
            return QSqlQueryModel::data(index, role);
        }
        else
        {

        return QSqlQueryModel::data(this->index(index.row(), role - Qt::UserRole - 1), Qt::DisplayRole);

                    }

}

QVariantMap AlgoSqlQueryModel::get( int rowNumber ) const
{
    QVariantMap map;
    QHash<int,QByteArray> roleName = roleNames();
    foreach (int i, roleName.keys())
    {
        // For each attribute (role) get its value and insert it into the map
        // where the map's key is the attributes string reference

        // The data() method returns the value for the requested attribute
        // where i is the attributes enum value.
        // The index() method returns a QModelIndex which is a further
        // abstraction layer (will talk about that in a later post)
        map[roleName.value(i)] = data( index( rowNumber,0 ), i );
    }
    return map;
}
