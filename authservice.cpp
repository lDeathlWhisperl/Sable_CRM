#include "authservice.h"
#include "qtbcrypt.h"

#include <QSettings>

AuthService::AuthService(QObject *parent)
    : QObject(parent)
{
    QObject::connect(&logVal, &LogInValidator::invalidLogin, this, &AuthService::invalidLogin);
    QObject::connect(&logVal, &LogInValidator::invalidPassword, this, &AuthService::invalidPassword);
    QObject::connect(&logVal, &LogInValidator::validLogin, this, &AuthService::validLogin);
    QObject::connect(&logVal, &LogInValidator::validPassword, this, &AuthService::validPassword);

    QObject::connect(&session, &SessionsRepository::token_expired, this, &AuthService::tokenAuth_expired);
}

std::optional<User> AuthService::authorize(const QString& login, const QString& password)
{
    logVal.validate(login, password);

    if(!logVal.val_res.loginValid || !logVal.val_res.passwordValid)
        return std::nullopt;

    UserRepository repo;
    std::optional<User> user = repo.getUserByLogin(login);

    if(!user)
    {
        qDebug() << "Пользователь не найден";
        emit userNotFound();
        return std::nullopt;
    }

    QString hash = QtBCrypt::hashPassword(password, user->password_hash);

    if(user->login != login || user->password_hash != hash)
    {
        qDebug() << "Не верный логин или пароль";
        emit incorrectData();
        return std::nullopt;
    }

    qDebug() << "Успешная авторизация";
    emit success();

    session.createSession(user->id);
    return user;
}

std::optional<User> AuthService::restoreSession()
{
    session.deleteExpired();

    if(QPair<bool, int> p = session.findByToken(); p.first)
    {
        qDebug() << "Session restored";
        emit success();

        UserRepository repo;
        std::optional<User> user = repo.getUserById(p.second);
        emit tokenAuth_success();

        return user;
    }

    return std::nullopt;
}

void AuthService::logoff()
{
    session.deleteSession();
    emit logout();
}
