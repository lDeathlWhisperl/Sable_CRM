#include <QGuiApplication>
#include <QQmlApplicationEngine>

#include "loginvalidator.h"

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    qmlRegisterType<LogInValidator>("loginvalidator", 1, 0,"LoginValidator");

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
