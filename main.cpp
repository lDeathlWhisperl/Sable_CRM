#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QSqlQuery>

#include "databasemanager.h"
#include "authviewmodel.h"

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    QCoreApplication::setOrganizationName("SableSoft");
    QCoreApplication::setApplicationName("Sable");

    DatabaseManager dbm;
    dbm.init();

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
