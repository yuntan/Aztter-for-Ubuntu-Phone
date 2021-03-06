import QtQuick 2.2
import QtQuick.Controls 1.1
import QtQuick.Layouts 1.1
import "components"
import "../js/Utils.js" as Utils

Item {
    id: tweetItem

    property string tweet
    property alias text: textLabel.text
    property alias createdAt: timeLabel.createdAt
    property alias fav: favIndicator.fav
    property alias name: nameLabel.text
    property alias screenName: screenNameLabel.text
    property alias iconSource: iconImage.source
    property alias verified: verifiedIcon.verified
    property alias isRT: rtRow.isRT
    property alias rtName: rtNameLabel.text
    property alias rtIconSource: rtIconImage.source

    readonly property int flickOffset1: 30*dp
    readonly property int flickOffset2: 55*dp
    readonly property int flickOffset3: 80*dp

    signal clicked()
    signal profileIconClicked()
    signal flicked(int index)

    width: ListView.view.width; height: tweetCard.height + 10*dp

    //	onSwiped: {
    //		console.log("Item swiped. index: " + index)
    //		onSwiped(index)
    //	}

    //	backgroundIndicator: Item {
    //		anchors.fill: parent

    //		Rectangle {
    //			anchors.fill: parent
    //			color: "#DD4814"
    //		}

    //		Label {
    //			anchors {
    //				left: swipingState === "SwipingLeft" ? parent.left : undefined
    //				right: swipingState === "SwipingRight" ? parent.right : undefined
    //				verticalCenter: parent.verticalCenter
    //			}

    //			text: swipingState === "SwipingRight"
    //				  ? "Swipe to RT >|"
    //				  : "|< Swipe to Fav"
    //			maximumLineCount: 1
    //			color: "white"
    //			font.bold: true
    ////			fontSize: "x-large" 34px
    //		}
    //	}
    Flickable {
        anchors.fill: parent
        contentWidth: tweetCard.width; contentHeight: tweetCard.height
        flickableDirection: Flickable.HorizontalFlick

        onContentXChanged: {

        }

        onDraggingChanged: {
            if(!dragging) {
                console.debug("contentX: %1".arg(contentX))
                if(Math.abs(contentX) < 30*dp) { return }
                if(Math.abs(contentX) < 55*dp) { flicked(contentX < 0 ? +1 : -1) }
                else if(Math.abs(contentX) < 80*dp) { flicked(contentX < 0 ? +2 : -2) }
                else { flicked(contentX < 0 ? +3 : -3) }
            }
        }

        Card {
            id: tweetCard

            anchors {
                top: parent.top
                margins: 10*dp
            }
            x: parent.x + 10*dp
            width: tweetItem.width - 20*dp; height: rtRect.height + mainRow.height + 15*dp

            onClicked: tweetItem.clicked()

            Rectangle {
                id: rtRect

                anchors {
                    top: parent.top
                    left: parent.left
                    right: parent.right
                }
                height: isRT ? 30*dp : 0
                color: "#601ebba6"

                RowLayout {
                    id: rtRow

                    anchors {
                        fill: parent
                        margins: 3*dp
                        leftMargin: 5*dp
                    }

                    spacing: 5*dp
                    property bool isRT: false
                    visible: isRT

                    AnimatedImage {
                        id: rtIconImage

                        Layout.preferredWidth: 25*dp
                        Layout.preferredHeight: 25*dp
                        fillMode: Image.PreserveAspectFit

                        Component.onCompleted: {
                            if(isRT && (source === undefined || source === ""))
                                source = Qt.resolvedUrl("qrc:/img/loading.png")
                        }
                    }

                    Label {
                        id: rtNameLabel

                        Layout.fillWidth: true
                        font.pixelSize: 15*dp
                        font.bold: true
                        maximumLineCount: 1
                        elide: Text.ElideRight
                        color: "#666666"
                    }
                }
            }

            RowLayout {
                id: mainRow

                anchors {
                    top: rtRect.bottom
                    left: parent.left
                    right: parent.right
                    margins: 5*dp
                }
                height: textCol.height
                spacing: 5*dp

                AnimatedImage {
                    id: iconImage

                    Layout.alignment: Qt.AlignTop
                    Layout.preferredWidth: 50*dp
                    Layout.preferredHeight: 50*dp
                    fillMode: Image.PreserveAspectFit

                    property url fallbackSource: Qt.resolvedUrl("qrc:/img/loading.png")

                    Component.onCompleted: {
                        if(source == undefined || source == "")
                            source = fallbackSource
                    }
                }

                ColumnLayout {
                    id: textCol

                    anchors.top: parent.top
                    Layout.fillWidth: true
                    spacing: 5*dp

                    RowLayout {
                        id: nameRow

                        Layout.fillWidth: true
                        Layout.preferredHeight: nameLabel.font.pixelSize
                        spacing: 1*dp

                        Label {
                            id: nameLabel

                            Layout.preferredWidth: implicitWidth
                            font.pixelSize: 15*dp
                            font.bold: true
                            maximumLineCount: 1
                            elide: Text.ElideRight
                            color: "#666666"
                        }

                        Image {
                            id: verifiedIcon
                            property bool verified

                            visible: verified
                            Layout.preferredWidth: verified ? parent.height : 0
                            Layout.preferredHeight: parent.height
                            source: "qrc:/img/verified.png"
                        }

                        Item {
                            Layout.minimumWidth: 5*dp
                        }

                        Label {
                            id: screenNameLabel

                            Layout.fillWidth: true
                            Layout.alignment: Qt.AlignBottom
                            font.pixelSize: 12*dp
                            maximumLineCount: 1
                            elide: Text.ElideRight
                            color: "#666666"
                        }

                        Image {
                            id: favIndicator
                            property bool fav

                            visible: fav
                            Layout.preferredWidth: fav ? parent.height : 0
                            Layout.preferredHeight: parent.height
                            source: "qrc:/img/star.png"
                        }
                    }

                    Label {
                        id: textLabel

                        Layout.fillWidth: true // needed to enable word wrap
                        font.pixelSize: 15*dp
                        wrapMode: Text.Wrap
                        textFormat: Text.StyledText
                        lineHeight: 1.2
                        color: "#666666"
                        onLinkActivated: {
                            console.log(link + " link activated")
                            Qt.openUrlExternally(link)
                        }
                    }

                    Item {
                        Layout.minimumHeight: 3*dp
                    }

                    Label {
                        id: timeLabel

                        Layout.fillWidth: true

                        property var createdAt

                        text: Utils.dateToStr(createdAt)
                        font.pixelSize: 12*dp
                        elide: Text.ElideNone
                        color: "#666666"
                    }
                }
            }
        }
    }
}

/*
//		Item {
//			id: controlContainer
//			property Item control
//			// use the width of the control if there is (possibly elided) text,
//			// or full width available if there is no text.
//			anchors.fill: parent
//			onControlChanged: {
//				if (control) control.parent = controlContainer;
//			}

//		Connections {
//			target: tweetItem.__mouseArea

//			onClicked: {
////                console.debug(control)
//				if (__mouseArea.mouseX > profileIcon.x
//						&& __mouseArea.mouseX < profileIcon.x + profileIcon.width
//						&& __mouseArea.mouseY > profileIcon.y
//						&& __mouseArea.mouseY < profileIcon.y + profileIcon.height) {
//					profileIconClicked();
//				} else {
//					tweetItem.clicked();
//				}
//			}

//			onPressAndHold: {
////                if (control && control.enabled && __mouseArea.mouseX < progressionHelper.x && control.hasOwnProperty("pressAndHold")) {
//				if (control && control.enabled && control.hasOwnProperty("pressAndHold")) {
//					control.pressAndHold();
//				} else {
//					tweetItem.pressAndHold();
//				}
//			}
//		}
//		}
*/

