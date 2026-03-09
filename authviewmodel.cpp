#include "authviewmodel.h"

AuthViewModel::AuthViewModel(QObject *parent)
{
    QObject::connect(&as, &AuthService::invalidLogin, this, &AuthViewModel::invalidLogin);
    QObject::connect(&as, &AuthService::invalidPassword, this, &AuthViewModel::invalidPassword);

    QObject::connect(&as, &AuthService::validLogin, this, &AuthViewModel::validLogin);
    QObject::connect(&as, &AuthService::validPassword, this, &AuthViewModel::validPassword);

    QObject::connect(&as, &AuthService::userNotFound, this, &AuthViewModel::userNotFound);
    QObject::connect(&as, &AuthService::incorrectData, this, &AuthViewModel::incorrectData);

    QObject::connect(&as, &AuthService::success, this, &AuthViewModel::success);
}
