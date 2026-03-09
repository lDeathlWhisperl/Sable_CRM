#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QSqlQuery>

#include "databasemanager.h"
#include "authviewmodel.h"

// #include "qtbcrypt.h"

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    QCoreApplication::setOrganizationName("SabelSoft");
    QCoreApplication::setApplicationName("Sabel");

    DatabaseManager dbm;
    dbm.init();

    // QString salt = QtBCrypt::generateSalt();
    // QString hash = QtBCrypt::hashPassword("Admin_#1", salt);
    // qDebug() << hash;

    qmlRegisterType<AuthViewModel>("authorization", 1, 0,"Authorization");

    QQmlApplicationEngine engine;
    QObject::connect(
        &engine,
        &QQmlApplicationEngine::objectCreationFailed,
        &app,
        []() { QCoreApplication::exit(-1); },
        Qt::QueuedConnection);
    engine.loadFromModule("Sable_CRM", "Authorization");

    return app.exec();
}
