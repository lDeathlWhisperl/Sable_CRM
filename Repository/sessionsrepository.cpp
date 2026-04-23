#include "sessionsrepository.h"
// #include "databasemanager.h"

#include <QUuid>
#include <QSqlQuery>
#include <QSqlError>
#include <QSettings>

#include <QCryptographicHash>

SessionsRepository::SessionsRepository(QObject *parent) : QObject(parent) { }

void SessionsRepository::createSession(int userId)
{
    QSqlQuery qu;
    qu.prepare("INSERT INTO Sessions (user_id, token, expires_at) "
               "VALUES (:userId, :token, datetime('now', 'localtime', '+7 days'))");

    QString token = QUuid::createUuid().toString(QUuid::WithoutBraces);
    QString hash = QCryptographicHash::hash(token.toUtf8(), QCryptographicHash::Sha256).toHex();

    qu.bindValue(":userId", userId);
    qu.bindValue(":token", hash);

    if(!qu.exec())
        qDebug() << "Session: " << qu.lastError().text();
    else
    {
        QSettings settings;
        settings.setValue("auth/token", token);
        qDebug() << "Auth token created";
    }
}

QPair<bool, int> SessionsRepository::findByToken()
{
    QSettings settings;
    QString token = settings.value("auth/token").toString();
    QPair<bool, int> pair;

    QSqlQuery qu;
    qu.prepare("SELECT user_id FROM Sessions "
               "WHERE token = ?");

    QString hash = QCryptographicHash::hash(token.toUtf8(), QCryptographicHash::Sha256).toHex();
    qu.bindValue(0, hash);

    if(!qu.exec())
    {
        qDebug() << "Session: " << qu.lastError().text();
        pair.first = false;
        return pair;
    }

    if(qu.next())
    {
        int user_id = qu.value(0).toInt();
        pair.first = true;
        pair.second = user_id;

        return pair;
    }

    qDebug() << "Authorization token not found";
    pair.first = false;
    return pair;

}

void SessionsRepository::deleteSession()
{
    QSettings settings;
    QString token = settings.value("auth/token").toString();

    QSqlQuery qu;
    qu.prepare("DELETE FROM Sessions "
               "WHERE token = ?");

    QString hash = QCryptographicHash::hash(token.toUtf8(), QCryptographicHash::Sha256).toHex();
    qu.bindValue(0, hash);

    if(!qu.exec())
        qDebug() << "Session: " << qu.lastError().text();
}

void SessionsRepository::deleteExpired()
{
    QSqlQuery qu;
    qu.prepare("DELETE FROM Sessions "
               "WHERE expires_at < CURRENT_TIMESTAMP");

    if(!qu.exec())
    {
        qDebug() << "Session: " << qu.lastError().text();
        return;
    }

    if(int affected = qu.numRowsAffected(); affected > 0)
    {
        qDebug() << "token expired";
        emit token_expired();
    }
}
