/*
 * Copyright 2013 Yuuto Tokunaga
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU Lesser General Public License as published by
 * the Free Software Foundation; version 3.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU Lesser General Public License for more details.
 *
 * You should have received a copy of the GNU Lesser General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

import QtQuick 2.1
import "components"

Page {
	id: timelineContainer
	title: qsTr("Timeline")

	Component.onCompleted: {
//        if(wallpaper.status === Image.Ready)
//            filter.color = Qt.rgba(56/255, 56/255, 55/255, 0.5) // DIC-G300
//        loadListView(settings.load("view/last_view"));
//		loadListView(0)
	}

	property int baseLength: height > width ? height : width
	property int currentIndex: -1
	property Component listView

	function loadListView(index) {
		console.debug("loadListView(" + index + ")");
		if(currentIndex != -1){
			listView.loadStop();
			listView.destroy();
		}
		var component = Qt.createComponent("Timeline.qml")
		listView = component.createObject(timelineContainer,
										  {"anchors.fill": timelineContainer, "z": 1})
		if(listView === null) {console.error("Error creating object") }
		else {
			console.debug("listView successfully created")
			currentIndex = index
		}
//        flickable = listView;
//        scrollBar.flickableItem = listView;
	}

	Timeline {
		anchors.fill: parent
		z: 1
	}

//    Tabs {
//        id: tabs

//        onSelectedTabIndexChanged: loadListView(selectedTabIndex)
//        Tab {title: i18n.tr("Home")}
////        Tab {title: i18n.tr("Mention")}
////        Tab {title: i18n.tr("List")}
//    }

	TweetBox {
		id: tweetBox

		z: 2
		visible: true
		anchors {
			left: parent.left
			right: parent.right
			bottom: parent.bottom
			margins: 1*mm
		}
	}

//    Scrollbar {
//        id: scrollBar

//        z: 20
//    }

	Image {
		id: wallpaper

		z: 0
		anchors.fill: parent
		source: Qt.resolvedUrl("file:///C:/WorkSpace/wallpaper.jpg")
		fillMode: Image.PreserveAspectCrop
	}
}
