#include "FileSaver.h"
#include <QGuiApplication>
#include <QQmlApplicationEngine>
int main(int argc, char* argv[])
{
#if QT_VERSION < QT_VERSION_CHECK(6, 0, 0)
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
#endif

    QGuiApplication app(argc, argv);
    app.setOrganizationDomain("www.HCoding.ir");
    app.setOrganizationName("Heydar Mahmoodi");

    qmlRegisterType<FileSaver>("ir.hcoding.modules", 1, 0, "FileSaver");
    QQmlApplicationEngine engine;
    const QUrl url(QStringLiteral("qrc:/main.qml"));
    QObject::connect(
        &engine,
        &QQmlApplicationEngine::objectCreated,
        &app,
        [url](QObject* obj, const QUrl& objUrl) {
            if(!obj && url == objUrl)
                QCoreApplication::exit(-1);
        },
        Qt::QueuedConnection);
    engine.load(url);
    QObject::connect(&engine, &QQmlApplicationEngine::quit, &QGuiApplication::quit);

    return app.exec();
}
