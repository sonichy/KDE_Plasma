import QtQuick 2.0
import QtQuick.Layouts 1.1
import QtQuick.Controls 1.6
 
import org.kde.plasma.plasmoid 2.0
import org.kde.plasma.core 2.0 as PlasmaCore
 
Item {
    id: root
 
    //readonly property date currentDateTime: dataSource.data.Local ? dataSource.data.Local.DateTime : new Date()
    readonly property date currentDateTime: new Date()
 
    width: PlasmaCore.Units.gridUnit * 10
    height: PlasmaCore.Units.gridUnit * 4
 
    Plasmoid.toolTipMainText: Qt.formatTime(currentDateTime, "hh:mm")
    Plasmoid.toolTipSubText: Qt.formatDate(currentDateTime, Qt.locale().dateFormat(Locale.LongFormat))
 
    PlasmaCore.DataSource {
        id: dataSource
        engine: "time"
        connectedSources: ["Local"]
        interval: 60000
        intervalAlignment: PlasmaCore.Types.AlignToMinute
    }
 
	Plasmoid.preferredRepresentation: Plasmoid.compactRepresentation
    Plasmoid.compactRepresentation: CompactRepresentation { }
   
    Plasmoid.fullRepresentation: Calendar {
    	id: calendar
        Layout.minimumWidth: PlasmaCore.Units.gridUnit * 20
        Layout.minimumHeight: PlasmaCore.Units.gridUnit * 20
        weekNumbersVisible: plasmoid.configuration.showWeekNumbers
    }
}
