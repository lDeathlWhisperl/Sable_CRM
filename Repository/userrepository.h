#ifndef USERREPOSITORY_H
#define USERREPOSITORY_H

#include <QString>
#include <QSqlDatabase>

struct User
{
    int id;
    QString login;
    QString password_hash;
    QString name;
    int role_id;
};

class UserRepository
{
    QSqlDatabase db;
    User user;
public:
    UserRepository();

    std::optional<User> getUserByLogin(const QString& login);
    bool createUser(const User& user);
    void updateUser(const User& user);
    User getUser() const { return user; }
    std::optional<User> getUserById(int user_id);
};

#endif // USERREPOSITORY_H
