#ifndef DEALSREPOSITORY_H
#define DEALSREPOSITORY_H

#include <QString>
#include <QDate>

struct Deal
{
    int id;
    int client_id;
    int manager_id;
    QDate delivery_date;
    QDate expiration_date;
    QString description;
    int status_id;
    double amount;
};

class DealsRepository
{
public:
    DealsRepository();
};

#endif // DEALSREPOSITORY_H
