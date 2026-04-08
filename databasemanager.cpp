#include "databasemanager.h"

#include <QSqlQuery>
#include <QSqlError>
#include <QStandardPaths>
#include <QFile>
#include <QDir>

QSqlDatabase DatabaseManager::db;

DatabaseManager::DatabaseManager()
{
    db.open();
}

bool DatabaseManager::init()
{
    qDebug() << "DB path: " << dbPath();
    if(!open())
    {
        qDebug() << "DB was not open";
        return false;
    }

    if(isInit()) return true;

    return createTables();
}

QSqlDatabase DatabaseManager::database()
{
    return db;
}

bool DatabaseManager::open()
{
    db = QSqlDatabase::addDatabase("QSQLITE");
    db.setDatabaseName(dbPath());

    if(!db.open())
    {
        qDebug() << "Database error: " << db.lastError().text();
        return false;
    }
    return true;
}

bool DatabaseManager::createTables()
{
    return runScript(":/qt/qml/Sable_CRM/Resources/DB/Script.sql");
}

bool DatabaseManager::runScript(const QString &path)
{
    QFile file(path);
    if(!file.open(QIODevice::ReadOnly | QIODevice::Text))
    {
        qDebug() << file.errorString();
        return false;
    }

    QString script = file.readAll();
    file.close();

    QStringList statements = script.split(';', Qt::SkipEmptyParts);

    for (const QString& stmt : std::as_const(statements))
    {
        QSqlQuery query(db);
        if (!query.exec(stmt))
        {
            qDebug() << "Script: " << query.lastError().text();
            return false;
        }
    }
    return true;
}

QString DatabaseManager::dbPath()
{
    QString path = QStandardPaths::writableLocation(QStandardPaths::AppDataLocation);

    if(QDir dir; !dir.exists(path))
        dir.mkpath(path);

    return path + "/Sabel.db";
}

bool DatabaseManager::isInit()
{
    QSqlQuery qu("PRAGMA user_version");

    if (qu.next())
    {
        int version = qu.value(0).toInt();
        qDebug() << "DB version: " << version << "\n Actual version: " << DB_version;
        if(version == DB_version)
            return true;
    }
    return false;
}
