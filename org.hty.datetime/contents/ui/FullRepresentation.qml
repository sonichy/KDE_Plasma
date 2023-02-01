import QtQuick 2.0
import QtQuick.Layouts 1.1
import QtQuick.Controls 1.6

import org.kde.plasma.core 2.0 as PlasmaCore

Item {
    Layout.minimumWidth: PlasmaCore.Units.gridUnit * 20
    Layout.minimumHeight: PlasmaCore.Units.gridUnit * 20
	
	ColumnLayout {
	 	Button {
	        text: i18n('Today')
	        anchors.right: parent.right
    	    onClicked: {
    	        calendar.selectedDate = new Date()
    	    }
    	}
    	
		Calendar {
		    id: calendar
			Layout.minimumWidth: PlasmaCore.Units.gridUnit * 20
    		Layout.minimumHeight: PlasmaCore.Units.gridUnit * 20
            weekNumbersVisible: plasmoid.configuration.showWeekNumbers
    	}
	}	
}
