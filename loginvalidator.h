#ifndef LOGINVALIDATOR_H
#define LOGINVALIDATOR_H

#include <QObject>

class LogInValidator : public QObject
{
    Q_OBJECT
private:

public:
    struct ValidationResult
    {
        bool loginValid    = true;
        bool passwordValid = true;

        QString loginError    = "";
        QString passwordError = "";

        void reset()
        {
            loginValid    = true;
            passwordValid = true;

            loginError    = "";
            passwordError = "";
        }
    }val_res;

    Q_PROPERTY(bool isLoginValid READ getLoginValid)
    Q_PROPERTY(bool isPasswordValid READ getPasswordValid)
    Q_PROPERTY(QString loginError READ getLoginError)
    Q_PROPERTY(QString passwordError READ getPasswordError)

    bool getLoginValid()       const { return val_res.loginValid;    }
    bool getPasswordValid()    const { return val_res.passwordValid; }
    QString getLoginError()    const { return val_res.loginError;    }
    QString getPasswordError() const { return val_res.passwordError; }

    LogInValidator(QObject *parent = nullptr);

    Q_INVOKABLE ValidationResult validate(QString login, QString password);
};

#endif // LOGINVALIDATOR_H
