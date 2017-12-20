#ifndef TICKETMODEL_H
#define TICKETMODEL_H

#include <QObject>

class TicketModel : public QObject
{
    Q_OBJECT
public:
    explicit TicketModel(QObject *parent = nullptr);

signals:

public slots:
};

#endif // TICKETMODEL_H