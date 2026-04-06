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
    if(!open())
        return false;

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
            qDebug() << query.lastError().text();
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

    qDebug() << "DB path: " << path + "/Sabel.db";

    return path + "/Sabel.db";
}
