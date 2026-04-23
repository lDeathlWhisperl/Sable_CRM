#ifndef ACCESSMANAGER_H
#define ACCESSMANAGER_H

#include "QSqlDatabase"
#include <QSet>

enum class Permissions
{
    CreateClient,
    EditClient,
    DeleteClient,
    CreateDeal,
    EditDeal
};

class AccessManager
{
    QSqlDatabase db;
    QSet<Permissions> permissions;
public:
    AccessManager(int user_id);

    bool hasPermission(Permissions perms);
    void loadPermissions();
};

#endif // ACCESSMANAGER_H
