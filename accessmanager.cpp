#include "accessmanager.h"
#include "databasemanager.h"

#include <QSqlQuery>
#include <QSqlError>

Permissions permissionFromString(const QString& str)
{


    throw std::runtime_error("Unknown permission");
}

AccessManager::AccessManager(int user_id)
{
    db = DatabaseManager::database();
}

bool AccessManager::hasPermission(Permissions perms)
{

}

void AccessManager::loadPermissions()
{
    QSqlQuery qu(db);
    qu.prepare( "SELECT P.Permission FROM RolePermissions AS RP"
                    "JOIN Roles AS R"
                    "ON R.id = RP.role_id"
                    "JOIN Permissions AS P"
                    "ON P.id = RP.permission_id"
                "WHERE R.role = ?");
}
