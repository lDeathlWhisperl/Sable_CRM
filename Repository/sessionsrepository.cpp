#include "sessionsrepository.h"
#include "databasemanager.h"

#include <QUuid>
#include <QSqlQuery>
#include <QSqlError>
#include <QSettings>

Session SessionsRepository::session;

SessionsRepository::SessionsRepository(QObject *parent)
    : QObject(parent)
{
    db = DatabaseManager::database();
}

void SessionsRepository::createSession(int userId)
{
    QSqlQuery qu(db);
    qu.prepare("INSERT INTO Sessions (user_id, token, expires_at) "
               "VALUES (:userId, :token, datetime('now', 'localtime', '+7 days'))");

    session =
    {
        .user_id = userId,
        .token = QUuid::createUuid().toString(QUuid::WithoutBraces)
    };

    qu.bindValue(":userId", session.user_id);
    qu.bindValue(":token", session.token);

    if(!qu.exec())
        qDebug() << "Session: " << qu.lastError().text();
    else
    {
        QSettings settings;
        settings.setValue("auth/token", session.token);
        qDebug() << "Auth token created";
    }
}

QPair<bool, int> SessionsRepository::findByToken()
{
    QSettings settings;
    QString token = settings.value("auth/token").toString();
    QPair<bool, int> pair;

    QSqlQuery qu(db);
    qu.prepare("SELECT user_id, token FROM Sessions "
               "WHERE token = ?");

    qu.bindValue(0, token);

    if(!qu.exec())
    {
        qDebug() << "Session: " << qu.lastError().text();
        pair.first = false;
        return pair;
    }

    if(qu.next())
        session.user_id = qu.value(0).toInt();
    else
    {
        qDebug() << "Authorization token not found";
        pair.first = false;
        return pair;
    }

    pair.first = true;
    pair.second = session.user_id;

    return pair;
}

void SessionsRepository::deleteSession()
{
    QSettings settings;
    QString token = settings.value("auth/token").toString();

    QSqlQuery qu(db);
    qu.prepare("DELETE FROM Sessions "
               "WHERE token = ?");

    qu.bindValue(0, token);

    if(!qu.exec())
        qDebug() << "Session: " << qu.lastError().text();
}

void SessionsRepository::deleteExpired()
{
    QSqlQuery qu(db);
    qu.prepare("DELETE FROM Sessions "
               "WHERE expires_at < CURRENT_TIMESTAMP");

    if(!qu.exec())
    {
        qDebug() << "Session: " << qu.lastError().text();
        return;
    }

    int affected = qu.numRowsAffected();

    if(affected > 0)
    {
        qDebug() << "token expired";
        emit token_expired();
    }
}
