#ifndef SESSIONSREPOSITORY_H
#define SESSIONSREPOSITORY_H

#include <QObject>
// #include <QSqlDatabase>
#include <QPair>

class SessionsRepository : public QObject
{
    Q_OBJECT

    // QSqlDatabase db;

signals:
    void token_expired();

public:
    SessionsRepository(QObject *parent = nullptr);

    void createSession(int userId);
    QPair<bool, int> findByToken();
    void deleteSession();
    void deleteExpired();
};

#endif // SESSIONSREPOSITORY_H
