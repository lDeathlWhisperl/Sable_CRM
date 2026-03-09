#ifndef AUTHSERVICE_H
#define AUTHSERVICE_H

#include <QObject>

#include "loginvalidator.h"
#include "userrepository.h"

class AuthService : public QObject
{
    Q_OBJECT
    LogInValidator logVal;
signals:
    void invalidPassword();
    void invalidLogin();
    void validPassword();
    void validLogin();
    void userNotFound();
    void incorrectData();
    void success();

public:
    AuthService(QObject *parent = nullptr);

    std::optional<User> authorize(const QString& login, const QString& password);
};

#endif // AUTHSERVICE_H
