#include "aztterhometlhelper.h"
#include <QJsonDocument>
#include <QJsonObject>
#include <QDebug>
#include "azttertweetenum.h"
#include "aztteruserstream.h"
#include "aztterfav.h"
#include "aztterstatusupdate.h"

AztterHomeTLHelper::AztterHomeTLHelper(QObject *parent) : QObject(parent)
{
	m_stream = new AztterUserStream(this);
	m_fav = new AztterFav(this);
	m_statusUpdate = new AztterStatusUpdate(this);

	connect(m_stream, SIGNAL( streamReceived(QByteArray) ), this, SLOT( parseStream(QByteArray) ));
	connect(m_fav, SIGNAL( finished(qint64,bool) ), this, SIGNAL( favChanged(qint64,bool) ));
//	connect(m_fav, SIGNAL( finished(AztterAPIBase::Status) ),
//			this, SLOT( onFinished(AztterAPIBase::Status) ));
//	connect(m_statusUpdate, SIGNAL( finished(AztterAPIBase::Status) ),
//			this, SIGNAL( onFinished(AztterAPIBase::Status) ));
}

AztterHomeTLHelper::~AztterHomeTLHelper()
{
	qDebug() << "AztterHomeTLHelper destroyed";
}

void AztterHomeTLHelper::startFetching() {m_stream->startFetching();}
void AztterHomeTLHelper::streamDisconnect() {m_stream->streamDisconnect();}

void AztterHomeTLHelper::fav(const qint64 tweetId) {m_fav->fav(tweetId);}
void AztterHomeTLHelper::unfav(const qint64 tweetId) {m_fav->unfav(tweetId);}

void AztterHomeTLHelper::rt(const QString tweetText, const QString userScreenName)
{
	m_statusUpdate->tweet("RT @" + userScreenName + ": " + tweetText);
}

void AztterHomeTLHelper::favrt(const qint64 tweetId, const QString tweetText,
							   const QString userScreenName)
{
	fav(tweetId);
	rt(tweetText, userScreenName);
}

void AztterHomeTLHelper::parseStream(const QByteArray &data)
{
	QJsonDocument jsonDoc = QJsonDocument::fromJson(data);

	if(jsonDoc.isObject()) {
		QJsonObject jsonObj = jsonDoc.object();
		if (jsonObj.contains("friends")) {
			qDebug() << "friends list received";
			parseFriendsList(jsonObj);
		} else if (jsonObj.contains("text")) {
			qDebug() << "tweet received";
			parseTweet(jsonObj);
		} else if (jsonObj.contains("delete")) {
			qDebug() << "delete received";
			parseDeleteTweet(jsonObj);
		} else if (jsonObj.contains("direct_message")) {
			qDebug() << "direct message received";
			parseDirectMessage(jsonObj);
		}
	}
}

void AztterHomeTLHelper::parseTweet(const QJsonObject &tweetObj)
{ // Do not forget overwrite!!
	m_tweet["TweetId"] = static_cast<qint64>(tweetObj["id"].toDouble());
	m_tweet["TweetText"] = tweetObj["text"].toString();
	m_tweet["TweetCreatedAt"] = tweetObj["created_at"].toString();
	m_tweet["TweetSource"] = tweetObj["source"].toString();
	m_tweet["TweetFavorited"] = tweetObj["favorited"].toBool();
	m_tweet["TweetRetweeted"] = tweetObj["retweeted"].toBool();

	QString id = tweetObj["in_reply_to_status_id"].toString();
	id == "null" ? m_tweet["TweetInReplyToStatusId"] = QVariant() // insert null
			: m_tweet["TweetInReplyToStatusId"] = static_cast<qint64>(id.toDouble());

	QJsonObject userObj = tweetObj["user"].toObject();
	m_tweet["UserId"] = static_cast<qint64>(userObj["id"].toDouble());
	m_tweet["UserName"] = userObj["name"].toString();
	m_tweet["UserScreenName"] = userObj["screen_name"].toString();
	m_tweet["UserProfileImageUrl"] = userObj["profile_image_url"].toString();
	m_tweet["UserVerified"] = userObj["verified"].toBool();

	emit tweetReceived(m_tweet);
}

void AztterHomeTLHelper::parseFriendsList(const QJsonObject &jsonObj)
{
	// TODO parse friendslist
	Q_UNUSED(jsonObj)
	emit friendsListReceived();
}

void AztterHomeTLHelper::parseDirectMessage(const QJsonObject &jsonObj)
{
	// TODO parse directmessaga
	Q_UNUSED(jsonObj)
	emit directMessageReceived();
}

void AztterHomeTLHelper::parseDeleteTweet(const QJsonObject &jsonObj)
{
	QJsonObject deleteStatusJson = jsonObj["delete"].toObject();
	QJsonObject statusJson = deleteStatusJson["status"].toObject();

	emit tweetDeleted( static_cast<qint64>(statusJson["id"].toDouble()) );
}
