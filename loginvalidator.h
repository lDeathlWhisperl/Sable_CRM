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
        bool loginValid    = false;
        bool passwordValid = false;

        void reset()
        {
            loginValid    = false;
            passwordValid = false;
        }
    }val_res;

    LogInValidator(QObject *parent = nullptr);

    void validate(const QString& login, const QString& password);

signals:
    void invalidLogin();
    void invalidPassword();
    void validLogin();
    void validPassword();
};

#endif // LOGINVALIDATOR_H
