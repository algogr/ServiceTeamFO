QT += quick sql
CONFIG += c++11 console

# The following define makes your compiler emit warnings if you use
# any feature of Qt which as been marked deprecated (the exact warnings
# depend on your compiler). Please consult the documentation of the
# deprecated API in order to know how to port your code away from it.
DEFINES += QT_DEPRECATED_WARNINGS

# You can also make your code fail to compile if you use deprecated APIs.
# In order to do so, uncomment the following line.
# You can also select to disable deprecated APIs only up to a certain version of Qt.
#DEFINES += QT_DISABLE_DEPRECATED_BEFORE=0x060000    # disables all the APIs deprecated before Qt 6.0.0

SOURCES += main.cpp \
    ticketmodel.cpp \
    email.cpp \
    variousexposed.cpp \
    algosqlquerymodel.cpp \
    algosqlrelationaltablemodel.cpp \
    algosqltablemodel.cpp

RESOURCES += qml.qrc

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

# Additional import path used to resolve QML modules just for Qt Quick Designer
QML_DESIGNER_IMPORT_PATH = $$PWD/designer

OTHER_FILES += \
    designer/Backend/*.qml


# Default rules for deployment.
qnx: target.path = /tmp/$${TARGET}/bin
else: unix:!android: target.path = /opt/$${TARGET}/bin
!isEmpty(target.path): INSTALLS += target

HEADERS += \
    ticketmodel.h \
    email.h \
    variousexposed.h \
    algosqlquerymodel.h \
    algosqlrelationaltablemodel.h \
    algosqltablemodel.h

DISTFILES += \
    Technician.qml

##win32:CONFIG(release, debug|release): LIBS += -L$$PWD/../libs/build-AlgoModelClasses-Desktop_Qt_5_10_0_MinGW_32bit2-Release/release/ -lAlgoModelClasses
#else:win32:CONFIG(debug, debug|release): LIBS += -L$$PWD/../libs/build-AlgoModelClasses-Desktop_Qt_5_10_0_MinGW_32bit2-Debug/debug/ -lAlgoModelClasses
#else:unix: LIBS += -L$$PWD/../libs/build-AlgoModelClasses-Desktop_Qt_5_10_0_GCC_64bit-Release/ -lAlgoModelClasses

#INCLUDEPATH += $$PWD/../libs/AlgoModelClasses/
#DEPENDPATH += $$PWD/../libs/AlgoModelClasses/




win32:CONFIG(release, debug|release): LIBS += -L$$PWD/../libs/build-SMTPEmail-Desktop_Qt_5_9_1_MinGW_32bit-Release/release/ -lSMTPEmail
else:win32:CONFIG(debug, debug|release): LIBS += -L$$PWD/../libs/build-SMTPEmail-Desktop_Qt_5_9_1_MinGW_32bit-Debug/debug/ -lSMTPEmail
else:unix: LIBS += -L$$PWD/../libs/build-SMTPEmail-Desktop_Qt_5_9_1_MinGW_32bit-Debug/ -lSMTPEmail

INCLUDEPATH += $$PWD/../libs/SmtpClient/
DEPENDPATH += $$PWD/../libs/SmtpClient/

#win32:CONFIG(release, debug|release): LIBS += -L$$PWD/../libs/build-AlgoModelClasses-Desktop_Qt_5_10_0_MinGW_32bit2-Release/release/ -lAlgoModelClasses
#else:win32:CONFIG(debug, debug|release): LIBS += -L$$PWD/../libs/build-AlgoModelClasses-Desktop_Qt_5_10_0_MinGW_32bit2-debug/debug/ -lAlgoModelClasses
#else:unix: LIBS += -L$$PWD/../libs/build-AlgoModelClasses-Desktop_Qt_5_10_0_MinGW_32bit2-Release/ -lAlgoModelClasses

#INCLUDEPATH += $$PWD/../libs/AlgoModelClasses
#DEPENDPATH += $$PWD/../libs/AlgoModelClasses
