#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QSqlQuery>
#include <QFont>
#include <QQmlContext>

#include "databasemanager.h"
#include "authviewmodel.h"

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    QCoreApplication::setOrganizationName("SableSoft");
    QCoreApplication::setApplicationName("Sable");

    DatabaseManager dbm;
    dbm.init();

    QFont font("Monserrat", 14);
    QGuiApplication::setFont(font);

    AuthViewModel auth;
    qmlRegisterSingletonInstance("App.auth", 1, 0, "AuthManager", &auth);
    // qmlRegisterType<AuthViewModel>("authorization", 1, 0,"AuthManager");

    QQmlApplicationEngine engine;
    QObject::connect(
        &engine,
        &QQmlApplicationEngine::objectCreationFailed,
        &app,
        []() { QCoreApplication::exit(-1); },
        Qt::QueuedConnection);
    engine.loadFromModule("Sable_CRM", "Window");

    return app.exec();
}
