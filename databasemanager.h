#ifndef DATABASEMANAGER_H
#define DATABASEMANAGER_H

#include <QSqlDatabase>

class DatabaseManager
{
    static QSqlDatabase db;
    const int DB_version = 1;
public:
    explicit DatabaseManager();

    bool init();
    static QSqlDatabase database();

    ~DatabaseManager()
    {
        if(db.isOpen()) db.close();
    }
private:
    bool open();
    bool createTables();
    bool runScript(const QString& path);
    QString dbPath();
    bool isInit();
};

#endif // DATABASEMANAGER_H
