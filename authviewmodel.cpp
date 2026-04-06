#include "authviewmodel.h"

AuthViewModel::AuthViewModel(QObject *parent)
{
    QObject::connect(&as, &AuthService::invalidLogin,    this, &AuthViewModel::invalidLogin);
    QObject::connect(&as, &AuthService::invalidPassword, this, &AuthViewModel::invalidPassword);

    QObject::connect(&as, &AuthService::validLogin,    this, &AuthViewModel::validLogin);
    QObject::connect(&as, &AuthService::validPassword, this, &AuthViewModel::validPassword);

    QObject::connect(&as, &AuthService::userNotFound,  this, &AuthViewModel::userNotFound);
    QObject::connect(&as, &AuthService::incorrectData, this, &AuthViewModel::incorrectData);

    QObject::connect(&as, &AuthService::success, this, &AuthViewModel::success);
    QObject::connect(&as, &AuthService::logout,  this, &AuthViewModel::logout);

    QObject::connect(&as, &AuthService::tokenAuth_success, this, &AuthViewModel::tokenAuth_success);
    QObject::connect(&as, &AuthService::tokenAuth_expired, this, &AuthViewModel::tokenAuth_expired);
}
