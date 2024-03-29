
#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQuickStyle>
#include <QQuickWindow>

#include "include/databasemanager.h"
#include "include/languageselector.h"
#include "include/questionsproxymodel.h"
#include "include/randomquestionfiltermodel.h"

int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    QGuiApplication app(argc, argv);
    app.setOrganizationName("Sandro Wißmann");
    app.setOrganizationDomain("Sandro Wißmann Private");

    QScopedPointer<DatabaseManager> databaseManager{new DatabaseManager};

    QScopedPointer<LanguageSelector> languageSelector(new LanguageSelector);

    QQmlApplicationEngine engine;

    qmlRegisterSingletonInstance<DatabaseManager>(
        "DatabaseManagers", 1, 0, "DatabaseManager", databaseManager.get());

    qmlRegisterSingletonInstance<QuestionsProxyModel>(
        "QuestionsProxyModels", 1, 0, "QuestionsProxyModel",
        databaseManager->questionsProxyModel());

    qmlRegisterSingletonInstance<RandomQuestionFilterModel>(
        "RandomQuestionFilterModels", 1, 0, "RandomQuestionFilterModel",
        databaseManager->randomQuestionFilterModel());

    qmlRegisterSingletonInstance<LanguageSelector>(
        "LanguageSelectors", 1, 0, "LanguageSelector", languageSelector.get());

    const QUrl url(QStringLiteral("qrc:/qml/main.qml"));
    QObject::connect(
        &engine, &QQmlApplicationEngine::objectCreated, &app,
        [url](QObject *obj, const QUrl &objUrl) {
            if (!obj && url == objUrl)
                QCoreApplication::exit(-1);
        },
        Qt::QueuedConnection);

    QObject::connect(languageSelector.get(), &LanguageSelector::languageChanged,
                     &engine, &QQmlApplicationEngine::retranslate);

    engine.load(url);

    QObject *object = engine.rootObjects().first();

    QObject::connect(
        object,
        SIGNAL(newEntryDataForDatabase(QString, QString, QString, QString,
                                       QString, int, QString)),
        databaseManager->questionsProxyModel(),
        SLOT(addEntry(QString, QString, QString, QString, QString, int,
                      QString)));

    QObject::connect(object, SIGNAL(rowMarkedForDeleteFromDatabase(int)),
                     databaseManager->questionsProxyModel(),
                     SLOT(removeEntry(int)));

    QObject::connect(
        object, SIGNAL(valueMarkedForUpdateInDatabase(int, QVariant, QString)),
        databaseManager->questionsProxyModel(),
        SLOT(changeValue(int, QVariant, QString)));

    return app.exec();
}
