#include "sandboxapp.h"

#include <QQmlContext>
#include <QWindow>
#include <QDebug>
#include <QDirIterator>

#include "statuswindow.h"
#include "spellchecker.h"

SandboxApp::SandboxApp(int &argc, char **argv)
    : QGuiApplication(argc, argv),
      m_handler(new Handler(this))
{
    connect(m_handler, &Handler::restartQml, this, &SandboxApp::restartEngine, Qt::QueuedConnection);

#ifdef QT_DEBUG
    connect(&m_watcher, &QFileSystemWatcher::directoryChanged, [this](const QString&) {
        restartEngine();
    });

#endif
}

void SandboxApp::startEngine()
{
    qmlRegisterType<StatusWindow>("Sandbox", 0, 1, "StatusWindow");
    qmlRegisterType<SpellChecker>("Sandbox", 0, 1, "Spellchecker");

#ifdef QT_DEBUG
    const QUrl url = QUrl::fromLocalFile(applicationDirPath() + "/../main.qml");
    m_watcher.addPath(applicationDirPath() + "/../");
//    m_watcher.addPath(applicationDirPath() + "/../../src");
    QDirIterator it(applicationDirPath() + "/../", QDir::Dirs | QDir::NoDotAndDotDot, QDirIterator::Subdirectories);
    while (it.hasNext()) {
        qDebug() << it.filePath();
        if (!it.filePath().isEmpty())
           qDebug() << m_watcher.addPath(it.filePath());
        it.next();
    }

#else
    const QUrl url(QStringLiteral("qrc:/main.qml"));
#endif

    m_engine.rootContext()->setContextProperty("app", m_handler);


#ifdef QT_DEBUG
    m_engine.addImportPath(applicationDirPath() + "/../../src");
#else
    m_engine.addImportPath(QStringLiteral("qrc:/src"));
#endif
    qDebug() << m_engine.importPathList();
    QObject::connect(&m_engine, &QQmlApplicationEngine::objectCreated,
        this, [url](QObject *obj, const QUrl &objUrl) {
            if (!obj && url == objUrl)
                QCoreApplication::exit(-1);
        }, Qt::QueuedConnection);
    m_engine.load(url);
}

void SandboxApp::restartEngine()
{
    const QUrl url(applicationDirPath() + "/../main.qml");
    QWindow *rootWindow = qobject_cast<QWindow*>(m_engine.rootObjects().at(0));
    if (rootWindow) {
        rootWindow->close();
        rootWindow->deleteLater();
    }
    m_engine.clearComponentCache();
    m_engine.load(url);
}
