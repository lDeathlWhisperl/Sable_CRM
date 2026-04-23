#ifndef AUTHVIEWMODEL_H
#define AUTHVIEWMODEL_H

#include <QObject>
#include "authservice.h"

class AuthViewModel : public QObject
{
    Q_OBJECT
    AuthService as;
public:
    AuthViewModel(QObject *parent = nullptr);

    Q_INVOKABLE void authorize(QString login, QString password)
    {
        as.authorize(login, password);
    }

    Q_INVOKABLE void restoreSession()
    {
        as.restoreSession();
    }

    Q_INVOKABLE void logoff()
    {
        as.logoff();
    }

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
};

#endif // AUTHVIEWMODEL_H
