import QtQuick 2.5
import QtQuick.Layouts 1.1
import org.kde.plasma.plasmoid 2.0
 
Item {
	anchors.fill: parent
	Layout.preferredWidth: textMetrics.width
	
	property var fontSize: 20
	property var fontFamily: "serif"
	property bool showSeconds: plasmoid.configuration.showSeconds
	
	TextMetrics {
        id: textMetrics
        font {
            //family: fontFamily
            pixelSize: fontSize
        }
        text: "00:00:00"
	}

	ColumnLayout {
		spacing: -6

		Text {
			id: time
			width: parent.width
		    color: theme.textColor
		    font.pixelSize: fontSize
			Layout.alignment: Qt.AlignCenter
		}
		
		Text {
			id: tdate
			width: parent.width
		    color: theme.textColor
		    font.pixelSize: fontSize - 5
			Layout.alignment: Qt.AlignCenter
		}
    }
    
    Timer {
        //interval: 1000  //定时器时间间隔,默认1000ms
        running: true  //是否开启定时，默认是false，当为true的时候，进入此界面就开始定时
        repeat: true   //是否重复定时,默认为false
        onTriggered: { //定时触发槽,定时完成一次就进入一次
        	var date = new Date()
        	if (showSeconds) {
        	    time.text = date.toLocaleString(Qt.locale(), "HH:mm:ss")
        	    tdate.text = date.toLocaleString(Qt.locale(), "M/d ddd")
        	} else {
        	    time.text = date.toLocaleString(Qt.locale(), "HH:mm")
          	    tdate.text = date.toLocaleString(Qt.locale(), "M/d ddd")
        	}
        }
    }
    
    MouseArea {
        anchors.fill: parent
        onClicked: {
        	plasmoid.expanded = !plasmoid.expanded
        }
    }
    
}
