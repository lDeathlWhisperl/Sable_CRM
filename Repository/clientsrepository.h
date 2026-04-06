#ifndef CLIENTSREPOSITORY_H
#define CLIENTSREPOSITORY_H

#include <QString>

struct Client
{
    int id;
    QString name;
    QString email;
    QString phone;
    int communication_id;
};

class ClientsRepository
{
public:
    ClientsRepository();
};

#endif // CLIENTSREPOSITORY_H
