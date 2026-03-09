#ifndef USERREPOSITORY_H
#define USERREPOSITORY_H

#include <QString>
#include <QSqlDatabase>

struct User
{
    int id;
    QString login;
    QString password_hash;
    int role_id;
};

class UserRepository
{
    QSqlDatabase db;
public:
    UserRepository(class DatabaseManager* dbm);

    std::optional<User> getUserByLogin(const QString& login);
    bool createUser(const User& user);
    void updateUser();
};

#endif // USERREPOSITORY_H
