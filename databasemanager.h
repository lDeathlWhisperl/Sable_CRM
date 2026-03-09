#ifndef DATABASEMANAGER_H
#define DATABASEMANAGER_H

#include <QSqlDatabase>

class DatabaseManager
{
    QSqlDatabase db;

public:
    explicit DatabaseManager();

    bool init();
    QSqlDatabase database() const;

    ~DatabaseManager()
    {
        if(db.isOpen()) db.close();
    }
private:
    bool open();
    bool createTables();
    bool runScript(const QString& path);
    QString dbPath();
};

#endif // DATABASEMANAGER_H
