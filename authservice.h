#ifndef AUTHSERVICE_H
#define AUTHSERVICE_H

#include <QObject>

#include "loginvalidator.h"
#include "userrepository.h"
#include "sessionsrepository.h"

class AuthService : public QObject
{
    Q_OBJECT
    LogInValidator logVal;
    SessionsRepository session;
signals:
    void invalidPassword();
    void invalidLogin();
    void validPassword();
    void validLogin();

    void userNotFound();
    void incorrectData();
    void success();
    void logout();
    void tokenAuth_success();
    void tokenAuth_expired();

public:
    AuthService(QObject *parent = nullptr);

    std::optional<User> authorize(const QString& login, const QString& password);
    void logoff();
    std::optional<User> restoreSession();
};

#endif // AUTHSERVICE_H
