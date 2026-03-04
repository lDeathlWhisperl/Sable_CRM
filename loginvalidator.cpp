#include "loginvalidator.h"

#include <QRegularExpression>

LogInValidator::LogInValidator(QObject *parent)
    : QObject(parent)
{

}

LogInValidator::ValidationResult LogInValidator::validate(QString login, QString password)
{
    static const QRegularExpression login_regex(R"(^(?!.*\s)(\+7\d{10})|(8\d{10})|([A-z]{5,})$)");
    static const QRegularExpression pass_regex(R"(^(?=.*[a-z])(?=.*[A-Z])(?=.*\W)(?=.*\d).{8,}$)");

    val_res.reset();

    if (login.isEmpty())
    {
        val_res.loginValid = false;
        val_res.loginError = "Не заполнено обязательное поле: Логин";
    }
    else if (!login_regex.match(login).hasMatch())
    {
        val_res.loginValid = false;
        val_res.loginError = "Логин не соответствует требованиям";
    }

    if (password.isEmpty())
    {
        val_res.passwordValid = false;
        val_res.passwordError = "Не заполнено обязательное поле: Пароль";
    }
    else if (!pass_regex.match(password).hasMatch())
    {
        val_res.passwordValid = false;
        val_res.passwordError = "Пароль не соответствует требованиям";
    }

    qDebug().noquote() << "Login validation:   " << val_res.loginValid    << val_res.loginError;
    qDebug().noquote() << "Password validation:" << val_res.passwordValid << val_res.passwordError;

    return val_res;
}
