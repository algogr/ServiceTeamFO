#include "ticketmodel.h"

TicketModel::TicketModel(QObject *parent ) : QAbstractListModel(parent)
{
    m_tickets.append({ "Angel Hogan", "Chapel St. 368 ", "Clearwater" , "0311 1823993" });
    m_tickets.append({ "Felicia Patton", "Annadale Lane 2", "Knoxville" , "0368 1244494" });
    m_tickets.append({ "Grant Crawford", "Windsor Drive 34", "Riverdale" , "0351 7826892" });
    m_tickets.append({ "Gretchen Little", "Sunset Drive 348", "Virginia Beach" , "0343 1234991" });
    m_tickets.append({ "Geoffrey Richards", "University Lane 54", "Trussville" , "0423 2144944" });
    m_tickets.append({ "Henrietta Chavez", "Via Volto San Luca 3", "Piobesi Torinese" , "0399 2826994" });
    m_tickets.append({ "Harvey Chandler", "North Squaw Creek 11", "Madisonville" , "0343 1244492" });
    m_tickets.append({ "Miguel Gomez", "Wild Rose Street 13", "Trussville" , "0343 9826996" });
    m_tickets.append({ "Norma Rodriguez", " Glen Eagles Street  53", "Buffalo" , "0241 5826596" });
    m_tickets.append({ "Shelia Ramirez", "East Miller Ave 68", "Pickerington" , "0346 4844556" });
    m_tickets.append({ "Stephanie Moss", "Piazza Trieste e Trento 77", "Roata Chiusani" , "0363 0510490" });
}

int TicketModel::rowCount(const QModelIndex &) const
{
    return m_tickets.count();
}

QVariant TicketModel::data(const QModelIndex &index, int role) const
{
    if (index.row() < rowCount())
        switch (role) {
        case FullNameRole: return m_tickets.at(index.row()).fullName;
        case AddressRole: return m_tickets.at(index.row()).address;
        case CityRole: return m_tickets.at(index.row()).city;
        case NumberRole: return m_tickets.at(index.row()).number;
        default: return QVariant();
    }
    return QVariant();
}

QHash<int, QByteArray> TicketModel::roleNames() const
{
    static const QHash<int, QByteArray> roles {
        { FullNameRole, "fullName" },
        { AddressRole, "address" },
        { CityRole, "city" },
        { NumberRole, "number" }
    };
    return roles;
}

QVariantMap TicketModel::get(int row) const
{
    const Ticket Ticket = m_tickets.value(row);
    return { {"fullName", Ticket.fullName}, {"address", Ticket.address}, {"city", Ticket.city}, {"number", Ticket.number} };
}

void TicketModel::append(const QString &fullName, const QString &address, const QString &city, const QString &number)
{
    int row = 0;
    while (row < m_tickets.count() && fullName > m_tickets.at(row).fullName)
        ++row;
    beginInsertRows(QModelIndex(), row, row);
    m_tickets.insert(row, {fullName, address, city, number});
    endInsertRows();
}

void TicketModel::set(int row, const QString &fullName, const QString &address, const QString &city, const QString &number)
{
    if (row < 0 || row >= m_tickets.count())
        return;

    m_tickets.replace(row, { fullName, address, city, number });
    dataChanged(index(row, 0), index(row, 0), { FullNameRole, AddressRole, CityRole, NumberRole });
}

void TicketModel::remove(int row)
{
    if (row < 0 || row >= m_tickets.count())
        return;

    beginRemoveRows(QModelIndex(), row, row);
    m_tickets.removeAt(row);
    endRemoveRows();
}
