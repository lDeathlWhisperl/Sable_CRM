#include "userrepository.h"
#include "databasemanager.h"

#include <QSqlQuery>
#include <QSqlError>

UserRepository::UserRepository()
{
    db = DatabaseManager::database();
}

std::optional<User> UserRepository::getUserByLogin(const QString &login)
{
    QSqlQuery qu(db);
    qu.prepare(
        "SELECT * FROM Users "
        "WHERE login = :login;"
    );

    qu.bindValue(":login", login);

    if(!qu.exec())
    {
        qDebug() << qu.lastError().text();
        return std::nullopt;
    }

    if(!qu.next())
        return std::nullopt;

    user =
    {
        .id = qu.value("id").toInt(),
        .login = qu.value("login").toString(),
        .password_hash = qu.value("password_hash").toString(),
        .name = qu.value("name").toString(),
        .role_id = qu.value("role_id").toInt()
    };

    return user;
}

bool UserRepository::createUser(const User &user)
{
    QSqlQuery qu(db);

    qu.prepare(
        "INSERT OR IGNORE INTO Users (login, password_hash, role_id) "
        "VALUES (:login, :password, :n, :role);"
    );

    qu.bindValue(":login", user.login);
    qu.bindValue(":password", user.password_hash);
    qu.bindValue(":n", user.name);
    qu.bindValue(":role", user.role_id);

    if(!qu.exec())
    {
        qDebug() << qu.lastError().text();
        return false;
    }
    return true;
}

void UserRepository::updateUser(const User &user)
{

}

std::optional<User> UserRepository::getUserById(int user_id)
{
    QSqlQuery qu(db);
    qu.prepare("SELECT * FROM Users "
               "WHERE id = ?");

    qu.bindValue(0, user_id);

    if(!qu.exec())
    {
        qDebug() << "User not found: " << qu.lastError().text();
        return std::nullopt;
    }

    if(qu.next())
        user =
            {
                .id = qu.value("id").toInt(),
                .login = qu.value("login").toString(),
                .password_hash = qu.value("password_hash").toString(),
                .name = qu.value("name").toString(),
                .role_id = qu.value("role_id").toInt()
            };

    return user;
}
