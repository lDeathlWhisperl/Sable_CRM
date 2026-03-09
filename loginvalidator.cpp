#include "loginvalidator.h"

#include <QRegularExpression>
#include <QStandardPaths>

LogInValidator::LogInValidator(QObject *parent) : QObject(parent) {}

void LogInValidator::validate(const QString& login, const QString& password)
{
    static const QRegularExpression login_regex(R"(^(?!.*\s)(\+7\d{10})|(8\d{10})|([A-z]{5,})$)");
    static const QRegularExpression pass_regex(R"(^(?=.*[a-z])(?=.*[A-Z])(?=.*\W)(?=.*\d).{8,}$)");

    val_res.reset();

    if (login.isEmpty())
    {
        emit invalidLogin();
        qDebug() << "Не заполнено обязательное поле: Логин";
    }
    else if (!login_regex.match(login).hasMatch())
    {
        emit invalidLogin();
        qDebug() << "Логин не соответствует требованиям";
    }
    else
    {
        val_res.loginValid = true;
        emit validLogin();
    }

    if (password.isEmpty())
    {
        emit invalidPassword();
        qDebug() << "Не заполнено обязательное поле: Пароль";
    }
    else if (!pass_regex.match(password).hasMatch())
    {
        emit invalidPassword();
        qDebug() << "Пароль не соответствует требованиям";
    }
    else
    {
        val_res.passwordValid = true;
        emit validPassword();
    }

    qDebug().noquote() << "Login validation:   " << val_res.loginValid;
    qDebug().noquote() << "Password validation:" << val_res.passwordValid;
}
