QT += quick
QT += quickcontrols2
QT += sql

CONFIG += c++17

# The following define makes your compiler emit warnings if you use
# any Qt feature that has been marked deprecated (the exact warnings
# depend on your compiler). Refer to the documentation for the
# deprecated API to know how to port your code away from it.
DEFINES += QT_DEPRECATED_WARNINGS

# You can also make your code fail to compile if it uses deprecated APIs.
# In order to do so, uncomment the following line.
# You can also select to disable deprecated APIs only up to a certain version of Qt.
#DEFINES += QT_DISABLE_DEPRECATED_BEFORE=0x060000    # disables all the APIs deprecated before Qt 6.0.0

HEADERS += \
        include/databasemanager.h \
        include/languageselector.h \
        include/questionsproxymodel.h \
        include/questionsqltablemodel.h \
        include/questionsqlcolumnnames.h \
        include/randomquestionfiltermodel.h

SOURCES += \
        src/databasemanager.cpp \
        src/languageselector.cpp \
        src/main.cpp \
        src/questionsproxymodel.cpp \
        src/questionsqltablemodel.cpp \
        src/randomquestionfiltermodel.cpp

RESOURCES += qml.qrc \
    translations.qrc

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH += src
QML_IMPORT_PATH += include

# Additional import path used to resolve QML modules just for Qt Quick Designer
QML_DESIGNER_IMPORT_PATH =

# Default rules for deployment.
qnx: target.path = /tmp/$${TARGET}/bin
else: unix:!android: target.path = /opt/$${TARGET}/bin
!isEmpty(target.path): INSTALLS += target


TRANSLATIONS = \
    translations/quiz.de.ts \
    translations/quiz.es.ts \
    translations/qtbase.de.ts \
    translations/qtbase.es.ts

DISTFILES += \
    ressources/images/Q1.jpg \
    ressources/images/apt.gif \
    ressources/images/go.gif \
    ressources/images/logo.jpg \
    ressources/images/mm.gif \
    ressources/images/soft.gif \
    ressources/images/start.jpg \
    ressources/images/tech.gif \
    ressources/images/unnamed (1).gif \
    ressources/images/unnamed.gif \
    translations/quiz.de.ts \
    translations/quiz.es.ts \
    translations/qtquickcontrols.de.ts \
    translations/qtquickcontrols.es.ts
