TARGET = aztter
TEMPLATE = app

QT += qml quick widgets network sql

SOURCES += main.cpp

OTHER_FILES += \
	qml/components/BusyIndicator.qml \
	qml/components/Card.qml \
	qml/components/FlatButton.qml \
	qml/components/Page.qml \
	qml/components/ScrollablePageWithTab.qml \
	qml/AuthPage.qml \
	qml/Empty.qml \
	qml/LoadingPage.qml \
	qml/main.qml \
	qml/Storage.qml \
	qml/Timeline.qml \
	qml/TimelineContainer.qml \
	qml/TweetBox.qml \
	qml/TweetItem.qml \
    qml/components/Shape.qml

RESOURCES += \
	qml.qrc \
	img.qrc

OBJECTS_DIR = tmp
MOC_DIR = tmp
INC_DIR = KQOAuth/include

QMAKE_CXXFLAGS += -std=c++0x

INCLUDEPATH += \
	KQOAuth/src \

# aztterplugin
HEADERS += \
	aztterplugin/aztterplugin.h \
	aztterplugin/aztterkeystore.h \
	aztterplugin/y.h \
	aztterplugin/e.h \
	aztterplugin/k.h \
	aztterplugin/aztterapibase.h \
	aztterplugin/aztterstatusupdate.h \
	aztterplugin/aztteruserstream.h \
	aztterplugin/aztterhometlhelper.h \
	aztterplugin/azttertweetlistmodel.h \
	aztterplugin/azttertweetenum.h \
	aztterplugin/aztterfav.h \
	aztterplugin/aztterlocalstorage.h \
	aztterplugin/aztterauthhelper.h \
	aztterplugin/aztterrt.h \
	aztterplugin/aztterhometl.h

SOURCES += \
	aztterplugin/aztterplugin.cpp \
	aztterplugin/aztterkeystore.cpp \
	aztterplugin/aztterapibase.cpp \
	aztterplugin/aztterstatusupdate.cpp \
	aztterplugin/aztteruserstream.cpp \
	aztterplugin/aztterhometlhelper.cpp \
	aztterplugin/azttertweetlistmodel.cpp \
	aztterplugin/aztterfav.cpp \
	aztterplugin/aztterlocalstorage.cpp \
	aztterplugin/aztterauthhelper.cpp \
	aztterplugin/aztterrt.cpp \
	aztterplugin/aztterhometl.cpp

# KQOAuth
PUBLIC_HEADERS += \
	KQOAuth/src/kqoauthmanager.h \
	KQOAuth/src/kqoauthrequest.h \
	KQOAuth/src/kqoauthrequest_1.h \
	KQOAuth/src/kqoauthrequest_xauth.h \
	KQOAuth/src/kqoauthglobals.h

PRIVATE_HEADERS += \
	KQOAuth/src/kqoauthrequest_p.h \
	KQOAuth/src/kqoauthmanager_p.h \
	KQOAuth/src/kqoauthauthreplyserver.h \
	KQOAuth/src/kqoauthauthreplyserver_p.h \
	KQOAuth/src/kqoauthutils.h \
	KQOAuth/src/kqoauthrequest_xauth_p.h

HEADERS += \
	$$PUBLIC_HEADERS \
	$$PRIVATE_HEADERS

SOURCES += \
	KQOAuth/src/kqoauthmanager.cpp \
	KQOAuth/src/kqoauthrequest.cpp \
	KQOAuth/src/kqoauthutils.cpp \
	KQOAuth/src/kqoauthauthreplyserver.cpp \
	KQOAuth/src/kqoauthrequest_1.cpp \
	KQOAuth/src/kqoauthrequest_xauth.cpp

DEFINES += KQOAUTH

ANDROID_EXTRA_LIBS =

ANDROID_PACKAGE_SOURCE_DIR = $$PWD/android
